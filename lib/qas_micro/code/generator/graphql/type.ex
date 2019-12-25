defmodule QasMicro.Code.Generator.Graphql.Type do
  use QasMicro.Code.Genetator.Template

  import QasMicro.Util.Helper
  import QasMicro.Code.Generator.Model, only: [create_fields: 1, update_fields: 1]

  alias QasMicro.Util.Sigil, as: QSigil
  alias QasMicro.Util.Map, as: QMap

  @external_resource Path.join(__DIR__, "type.eex")
  # relation keys can be used in qas
  @relation_keys [:has_many, :many_to_many, :has_one, :belongs_to, :embeds_one, :embeds_many]

  def render(config_module, object) do
    if Map.get(object, :graphql, true) do
      object_name = get_value_or_raise(object, :name)

      schema_type_module_name = config_module.schema_module(object_name)
      type_module_name = config_module.model_module(object_name)
      resolver_module_name = config_module.resolver_module()
      authorize_module_name = config_module.middleware_module("authorize")

      auth = plugin_enabled?(object, :auth)
      password = plugin_enabled?(object, :password)
      wechat = plugin_enabled?(object, :wechat)
      wechat_jsapi_pay = plugin_enabled?(object, :wechat_jsapi_pay)
      alipay_app_pay = plugin_enabled?(object, :alipay_app_pay)
      wechat_app_pay = plugin_enabled?(object, :wechat_app_pay)

      normal_status_mutation_attrs =
        object
        |> Map.get(:validation, [])
        |> Enum.find(&(&1.name == "status"))
        |> case do
          nil ->
            []

          status ->
            field = status |> Map.get(:name) |> QSigil.to_atom()
            normal_statuses = status |> Map.get(:normal) |> QSigil.to_atom() |> List.wrap()
            {field, normal_statuses}
        end

      wechat_login_field =
        object
        |> QMap.get(:"auth.wechat")
        |> case do
          nil -> nil
          true -> ["field(:code, :string)"]
        end

      wechat_miniapp_auth_field =
        object
        |> QMap.get(:"auth.wechat_miniapp")
        |> case do
          nil -> nil
          true -> ["field(:code, :string)", "field(:info, :json)"]
        end

      normal_login_field =
        object
        |> QMap.get(:"auth.normal")
        |> case do
          nil ->
            nil

          value ->
            value
            |> QSigil.parse()
            |> Enum.map(&"field(:#{&1}, :string)")
        end

      sms_auth_field =
        object
        |> QMap.get(:"auth.sms")
        |> case do
          nil ->
            nil

          value ->
            value
            |> QSigil.parse()
            |> Enum.map(&"field(:#{&1}, :string)")
        end

      cellphone_auth = QMap.get(object, :"auth.cellphone")

      type_extension = QMap.get(object, :"extension.type", %{})
      type_field_schema = render_type_field(object, password)
      create_field_schema = render_create_field(object, password)
      update_field_schema = render_update_field(object, password)
      filter_field_schema = render_filter_field(object)
      type_relation_schema = render_relation_field(type_module_name, object, config_module)

      eex_template_string()
      |> EEx.eval_string(
        application_name: config_module.name(),
        schema_type_module_name: schema_type_module_name,
        type_module_name: type_module_name,
        name: object_name,
        normal_status_mutation_attrs: normal_status_mutation_attrs,
        resolver_module_name: resolver_module_name,
        type_field_schema: type_field_schema,
        type_relation_schema: type_relation_schema,
        filter_field_schema: filter_field_schema,
        create_field_schema: create_field_schema,
        update_field_schema: update_field_schema,
        password: password,
        wechat: wechat,
        auth: auth,
        type_extension: type_extension,
        alipay_app_pay: alipay_app_pay,
        wechat_app_pay: wechat_app_pay,
        wechat_jsapi_pay: wechat_jsapi_pay,
        normal_login_field: normal_login_field,
        wechat_login_field: wechat_login_field,
        wechat_miniapp_auth_field: wechat_miniapp_auth_field,
        cellphone_auth: cellphone_auth,
        sms_auth_field: sms_auth_field,
        authorize_module_name: authorize_module_name
      )
      |> config_module.save_file("#{object_name}.ex", "schema")
    else
      false
    end
  end

  defp render_type_field(object, _password) do
    fields =
      object
      |> QMap.get(:plugin, [])
      |> Enum.reduce(QMap.get(object, :field, []), fn
        {:wechat, true}, acc -> [%{name: "wechat_digest", type: "string"} | acc]
        {:password, true}, acc -> [%{name: "password_digest", type: "string"} | acc]
        {:unique_number, true}, acc -> [%{name: "unique_number", type: "string"} | acc]
        _, acc -> acc
      end)
      |> Enum.filter(&(&1.name != "password_digest"))
      |> Kernel.++(
        object
        |> QMap.get(:schema, [])
        |> Enum.filter(&(!Enum.member?(@relation_keys, &1 |> Map.get(:type) |> QSigil.to_atom())))
      )
      |> Enum.map(&render_field(&1, :render))

    case Map.get(object, :timestamp, true) do
      true ->
        fields ++
          [
            "field(:id, :integer)",
            "field(:inserted_at, :naive_datetime)",
            "field(:updated_at, :naive_datetime)"
          ]

      false ->
        ["field(:id, :integer)" | fields]
    end
  end

  defp render_create_field(object, _password) do
    object
    |> Map.get(:field, [])
    |> Kernel.++(Map.get(object, :schema, []))
    |> Enum.filter(
      &Enum.member?(
        object |> create_fields() |> Map.get(:content),
        &1.name |> String.to_atom()
      )
    )
    |> Enum.map(&render_field(&1, :create))
  end

  defp render_update_field(object, _password) do
    fields =
      object
      |> Map.get(:field, [])
      |> Kernel.++(Map.get(object, :schema, []))
      |> Enum.filter(
        &Enum.member?(
          object |> update_fields() |> Map.get(:content),
          &1.name |> String.to_atom()
        )
      )

    cast_fields =
      Enum.reduce(fields, fields, fn
        %{type: "files", name: name}, acc ->
          [%{name: "old_#{name}", type: "json"} | acc]

        _, acc ->
          acc
      end)

    Enum.map(cast_fields, &render_field(&1, :update))
  end

  defp render_filter_field(object) do
    plugin_filter_fields =
      object
      |> Map.get(:plugin, [])
      |> Enum.reduce([], fn
        {:wechat, _v}, acc ->
          [%{name: "wechat_digest", type: "json"} | acc]

        {:unique_number, _v}, acc ->
          [%{name: "unique_number", type: "json"} | acc]

        {_, _v}, acc ->
          acc
      end)

    object
    |> Map.get(:field, [])
    |> Enum.filter(&Map.get(&1, :filter, true))
    |> Kernel.++(plugin_filter_fields)
    |> Kernel.++([%{name: "custom", type: "json"}])
    |> Enum.map(&render_field(&1, :filter))
  end

  defp render_relation_field(type_module_name, object, config_module) do
    object
    |> Map.get(:schema, [])
    |> Enum.filter(&Enum.member?(@relation_keys, &1 |> Map.get(:type) |> QSigil.to_atom()))
    |> Enum.map(&render_relation_string(&1, type_module_name, config_module))
  end

  def render_relation_string(item, type_module_name, _config_module) do
    relation_type = get_value_or_raise(item, :type)
    type_name = get_value_or_raise(item, :name)
    relation_name = Map.get(item, :target) || type_name
    fetch_way = Map.get(item, :fetch_way)
    through = Map.get(item, :through)

    case relation_type do
      relation_type when relation_type in ["has_many", "many_to_many", "embeds_many"] ->
        if fetch_way do
          """
          field :#{Inflex.pluralize(type_name)}, list_of(:#{relation_name}) do
            arg(:filter, :filter_#{relation_name}_input)
            arg(:order, list_of(:order_input))
            arg(:pagination, :paginate_input)
            resolve(
              Resolver.relation_query(
                #{type_module_name},
                :#{Inflex.pluralize(type_name)},
                #{type_module_name}.fetch_way(:#{type_name})
              )
            )
          end
          """
        else
          if through do
            """
            field :#{Inflex.pluralize(type_name)}, list_of(:#{relation_name}) do
              arg(:filter, :filter_#{relation_name}_input)
              arg(:order, list_of(:order_input))
              arg(:pagination, :paginate_input)
              resolve(Resolver.relation_query(#{type_module_name}, :#{Inflex.pluralize(type_name)}, :through))
            end
            """
          else
            """
            field :#{Inflex.pluralize(type_name)}, list_of(:#{relation_name}) do
              arg(:filter, :filter_#{relation_name}_input)
              arg(:order, list_of(:order_input))
              arg(:pagination, :paginate_input)
              resolve(Resolver.relation_query(#{type_module_name}, :#{Inflex.pluralize(type_name)}, :normal))
            end
            """
          end
        end

      relation_type when relation_type in ["belongs_to", "has_one", "embeds_one"] ->
        if through do
          """
          field :#{type_name}, :#{relation_name} do
            resolve(Resolver.relation_query(#{type_module_name}, :#{type_name}, :one_through))
          end
          """
        else
          """
          field :#{type_name}, :#{relation_name} do
            resolve(Resolver.relation_query(#{type_module_name}, :#{type_name}, :one))
          end
          """
        end

      _ ->
        raise("can't parse the relation type #{relation_type}.")
    end
  end

  defp render_field(field, action) do
    {:field, [], []}
    |> pipe_into(0, field |> Map.get(:name) |> QSigil.to_atom())
    |> pipe_into(1, field |> Map.get(:type) |> QSigil.to_atom() |> get_graphql_type(action))
    |> Macro.to_string()
  end

  defp get_graphql_type(origin_type, action) do
    case action do
      :render ->
        case origin_type do
          :text -> :string
          origin_type when origin_type in [:file, :files] -> :json
          {:array, :map} -> :json
          :map -> :json
          :jsons -> :json
          _ -> QSigil.to_atom(origin_type)
        end

      :filter ->
        :json

      _ ->
        case origin_type do
          :text -> :string
          :file -> :upload
          :files -> quote do: list_of(:upload)
          {:array, :map} -> :json
          :map -> :json
          :jsons -> :json
          _ -> QSigil.to_atom(origin_type)
        end
    end
  end
end
