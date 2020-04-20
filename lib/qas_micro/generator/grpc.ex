defmodule QasMicro.Generator.Grpc do
  def render_endpoint(config_module) do
    application_name = config_module.name()
    camel_app_name = Macro.camelize(application_name)

    EEx.eval_string(endpoint_template(),
      camel_app_name: camel_app_name
    )
    |> config_module.save_file("endpoint.ex")
  end

  def render_server(config_module) do
    application_name = config_module.name()
    camel_app_name = Macro.camelize(application_name)
    objects = config_module.parse_object()

    grpc_method_delegates = Enum.map(objects, &object_method_template(config_module, &1))

    EEx.eval_string(server_template(),
      camel_app_name: camel_app_name,
      grpc_method_delegates: grpc_method_delegates
    )
    |> config_module.save_file("server.ex")
  end

  def render_transaction(config_module) do
    repo_name = config_module.repo_module()
    application_name = config_module.name()
    camel_app_name = Macro.camelize(application_name)

    EEx.eval_string(transaction_template(),
      camel_app_name: camel_app_name,
      repo_name: repo_name
    )
    |> config_module.save_file("transaction.ex", nil, false)
  end

  defp object_method_template(config_module, object) do
    object_name = object.name
    polymorphic = Map.get(object, :polymorphic, false)
    join_table = Map.get(object, :join_table, false)
    model_module = config_module.model_module(object_name)

    m2m_fields =
      object
      |> Map.get(:field, [])
      |> Enum.filter(&(Map.get(&1, :type) == "has_many" && Map.get(&1, :many_to_many)))

    if !polymorphic && !join_table do
      custom_query_fields =
        object
        |> Map.get(:query, [])
        |> Enum.map(fn item ->
          """
          defdelegate #{Map.get(item, :name)}(input, stream), to: #{model_module}
          """
        end)
        |> Enum.join("\n")

      custom_mutation_fields =
        object
        |> Map.get(:mutation, [])
        |> Enum.map(fn item ->
          """
          defdelegate #{Map.get(item, :name)}(input, stream), to: #{model_module}
          """
        end)
        |> Enum.join("")

      m2m_query_fields =
        m2m_fields
        |> Enum.map(fn field ->
          table_name = field.many_to_many
          query_name = "list_#{table_name}_#{Inflex.pluralize(object_name)}"

          """
          defdelegate #{query_name}(params, stream), to: #{model_module}
          """
        end)

      """
      defdelegate list_#{object_name}(common_id, stream), to: #{model_module}
      defdelegate list_#{Inflex.pluralize(object_name)}(params, stream), to: #{model_module}
      defdelegate create_#{object_name}(create_input, stream), to: #{model_module}
      defdelegate update_#{object_name}(update_input, stream), to: #{model_module}
      defdelegate delete_#{object_name}(common_id, stream), to: #{model_module}
      #{m2m_query_fields}
      #{custom_query_fields}
      #{custom_mutation_fields}
      """
    else
      if polymorphic do
        """
        defdelegate list_#{Inflex.pluralize(object_name)}(input, stream), to: #{model_module}
        """
      else
        ""
      end
    end
  end

  def endpoint_template do
    """
    defmodule <%= camel_app_name %>.Endpoint do
      use GRPC.Endpoint

      intercept GRPC.Logger.Server
      run <%= camel_app_name %>.<%= camel_app_name %>.Server
      run <%= camel_app_name %>.Transaction.Server
      run <%= camel_app_name %>.Authority.Server
      run <%= camel_app_name %>.Advanced.Server
      run Health.Server
    end
    """
  end

  def server_template do
    """
    defmodule <%= camel_app_name %>.<%= camel_app_name %>.Server do
      use GRPC.Server, service: <%= camel_app_name %>.<%= camel_app_name %>.Service

      <%= for template <- grpc_method_delegates do %><%= template %>
      <% end %>
    end
    """
  end

  def transaction_template do
    ~S"""
    defmodule <%= camel_app_name %>.Transaction.Server do
      use GRPC.Server, service: QasMicro.Transaction.Service

      alias QasMicro.Util.Map, as: QMap
      alias <%= camel_app_name %>.<%= camel_app_name %>.Server, as: Server

      def transaction(request_enum, _stream) do
        <%= repo_name %>.transaction(fn ->
          Enum.reduce(request_enum, [], fn %{action: action, input: input}, acc ->
            {:ok, cast_input} = assemble_input(input, acc)

            # use an empty map to replace with the origin stream param in Server call
            Server
            |> apply(String.to_atom(action), [cast_input, %{}])
            |> check_action_result(action, acc)
          end)
        end)
        |> case do
          {:ok, result} ->
            QasMicro.TransactionResult.new(%{
              status: "ok",
              result:
                result
                |> List.last
                |> struct_to_map
                |> Jason.encode!
            })

          {:error, reason} when is_binary(reason) ->
            QasMicro.TransactionResult.new(%{status: "error", result: reason})

          {:error, reason} ->
            QasMicro.TransactionResult.new(%{status: "error", result: inspect(reason)})
        end
      end

      # check action result
      defp check_action_result(result, action, params) do
        case result do
          %{errors: []}  ->
            Enum.concat(params, [result])

          %{errors: errors}  ->
            <%= repo_name %>.rollback("#{action} return #{inspect(errors)}")

          %{status: "failed"} ->
            <%= repo_name %>.rollback("#{action} return failed")

          _ ->
            Enum.concat(params, [result])
        end
      end

      # assemble the real input
      defp assemble_input(input, params) do
        case Jason.decode(input, keys: :atoms) do
          {:ok, input_map} ->
            {:ok,
              input_map
              |> Enum.map(fn {key, value} -> {key, value_in_binding(params, value)} end)
              |> Enum.into(%{})
            }

          {:error, _} ->
            <%= repo_name %>.rollback("JSON decode input with error")
        end
      end

      # key example:
      # $1.user.id, $2.user.name
      defp value_in_binding(params, map) when is_map(map) do
        map
        |> Enum.map(fn {key, value} -> {key, value_in_binding(params, value)} end)
        |> Enum.into(%{})
      end

      defp value_in_binding(params, value) when is_binary(value) do
        if match = Regex.named_captures(~r/^\$(?<index>\d+)\.(?<chain>.+)/, value) do
          %{"index" => index, "chain" => chain} = match

          params
          |> Enum.at(String.to_integer(index) - 1)
          |> QMap.get(String.to_atom(chain))
        else
          value
        end
      end

      defp value_in_binding(_params, value), do: value

      defp struct_to_map(list) when is_list(list) do
        Enum.map(list, fn item -> struct_to_map(item) end)
      end

      defp struct_to_map(%{__struct__: _} = struct) do
        struct
        |> Map.delete(:__struct__)
        |> struct_to_map()
      end

      defp struct_to_map(map) when is_map(map) do
        map
        |> Enum.map(fn {key, value} -> {key, struct_to_map(value)} end)
        |> Enum.into(%{})
      end

      defp struct_to_map(other), do: other
    end
    """
  end
end
