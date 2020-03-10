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

  defp object_method_template(config_module, object) do
    object_name = object.name
    polymorphic = Map.get(object, :polymorphic, false)
    join_table = Map.get(object, :join_table, false)
    model_module = config_module.model_module(object_name)

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

      """
      defdelegate list_#{object_name}(common_id, stream), to: #{model_module}
      defdelegate list_#{Inflex.pluralize(object_name)}(params, stream), to: #{model_module}
      defdelegate create_#{object_name}(create_input, stream), to: #{model_module}
      defdelegate update_#{object_name}(update_input, stream), to: #{model_module}
      defdelegate delete_#{object_name}(common_id, stream), to: #{model_module}
      #{custom_query_fields}
      #{custom_mutation_fields}
      """
    else
      ""
    end
  end

  def endpoint_template do
    """
    defmodule <%= camel_app_name %>.Endpoint do
      use GRPC.Endpoint

      intercept GRPC.Logger.Server
      run <%= camel_app_name %>.<%= camel_app_name %>.Server
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
end
