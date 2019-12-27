defmodule QasMicro.Generator.Model do
  use QasMicroGenetator.Template

  import QasMicro.Util.Helper

  alias QasMicro.Util.Unit
  alias QasMicro.Util.Sigil, as: QSigil
  alias QasMicro.Util.Map, as: QMap

  @external_resource Path.join(__DIR__, "model/plugin.eex")
  @relation_keys [:has_many, :many_to_many, :has_one, :belongs_to, :embeds_one, :embeds_many]

  def render(config_module, object) do
    object_name = object.name
    table_name = Map.get(object, :table_name, Inflex.pluralize(object_name))
    timestamp = Map.get(object, :timestamp, true)

    application_name = config_module.name()
    repo_module = config_module.repo_module()
    model_module = config_module.model_module(object_name)
    model_plugin_module = config_module.plugin_model_module(object_name)
    wechat_module = config_module.wechat_module()
    guardian_module = config_module.guardian_module()
    schema_module_name = config_module.schema_module()

    field_schema = QasMicro.Generator.Model.Field.render(object)
    relation_schema = QasMicro.Generator.Model.Relation.render(config_module, object)
    validations = QasMicro.Generator.Model.Validation.render(object)

    all_fields = all_fields(object)
    create_fields = create_fields(object)
    update_fields = update_fields(object)

    auth = plugin_enabled?(object, :auth)
    password = plugin_enabled?(object, :password)
    unique_number = plugin_enabled?(object, :unique_number)
    polymorphic = plugin_enabled?(object, :polymorphic)
    geometry = plugin_enabled?(object, :geometry)

    status_changeset_methods = status_changeset_methods(object)

    wechat_auth = QMap.get(object, :"auth.wechat")
    wechat_miniapp_auth = QMap.get(object, :"auth.wechat_miniapp")
    normal_auth = QMap.get(object, :"auth.normal")
    cellphone_auth = QMap.get(object, :"auth.cellphone")
    sms_auth = QMap.get(object, :"auth.sms")

    eex_template_string()
    |> EEx.eval_string(
      # modules
      config_module: config_module,
      model_module: model_module,
      model_plugin_module: model_plugin_module,
      wechat_module: wechat_module,
      repo_module_name: repo_module,
      guardian_module_name: guardian_module,
      schema_module_name: schema_module_name,
      # names
      application_name: application_name,
      object_name: object_name,
      table_name: table_name,
      # schema
      field_schema: field_schema,
      relation_schema: relation_schema,
      timestamp: timestamp,
      # the fields
      all_fields: Unit.new(all_fields),
      create_fields: create_fields,
      update_fields: update_fields,
      # field validations
      create_validation: Map.get(validations, :create, []),
      update_validation: Map.get(validations, :update, []),
      # status sepcial part
      status_changeset_methods: status_changeset_methods,
      # plugin
      password: password,
      auth: auth,
      unique_number: unique_number,
      normal_auth: normal_auth,
      wechat_auth: wechat_auth,
      wechat_miniapp_auth: wechat_miniapp_auth,
      cellphone_auth: cellphone_auth,
      sms_auth: sms_auth,
      polymorphic: polymorphic,
      geometry: geometry
    )
    |> config_module.save_file("#{object_name}.ex", "plugin/model")

    QasMicro.Generator.Model.Plugin.render(
      config_module,
      object_name,
      model_module,
      model_plugin_module
    )
  end

  defp status_changeset_methods(object) do
    object
    |> Map.get(:validation, [])
    |> Enum.find(&(&1.type == "status"))
    |> case do
      nil ->
        []

      status ->
        field = status |> Map.get(:name) |> String.to_atom()
        statuses = status |> Map.get(:data) |> QSigil.to_atom()
        normal_statuses = status |> Map.get(:normal) |> QSigil.to_atom()

        normal_statuses
        |> List.wrap()
        |> Enum.map(fn status ->
          method_name = String.to_atom("#{field}_#{status}_changeset")

          quote do
            def unquote(method_name)(struct, _role \\ :visitor) do
              struct
              |> Ecto.Changeset.put_change(unquote(field), unquote(status))
              |> Ecto.Changeset.validate_change(
                unquote(field),
                fn unquote(field), value ->
                  if old = Map.get(struct, unquote(field)) do
                    old_index = Enum.find_index(unquote(statuses), &(&1 == old))
                    new_index = Enum.find_index(unquote(statuses), &(&1 == value))

                    if old_index <= new_index do
                      []
                    else
                      [{unquote(field), "bad status change"}]
                    end
                  else
                    [{unquote(field), "bad status change"}]
                  end
                end
              )
            end
          end
          |> Macro.to_string()
        end)
    end
  end

  def all_fields(object) do
    object
    |> Map.get(:plugin, [])
    |> Enum.reduce(
      object
      |> QMap.get(:field, [])
      |> Enum.filter(&(!Enum.member?(@relation_keys, &1.type |> String.to_atom()))),
      fn
        {:wechat, true}, acc -> [%{name: "wechat_digest", type: "string"} | acc]
        {:password, true}, acc -> [%{name: "password_digest", type: "string"} | acc]
        {:unique_number, true}, acc -> [%{name: "unique_number", type: "string"} | acc]
        _, acc -> acc
      end
    )
    |> Kernel.++(Enum.filter(QMap.get(object, :schema, []), &Map.get(&1, :virtual)))
    |> Enum.map(&String.to_atom(&1.name))
  end

  def create_fields(object) do
    origin_fields =
      object
      |> Map.get(:schema, [])
      |> Enum.filter(&Map.get(&1, :virtual, false))
      |> Kernel.++(
        object
        |> QMap.get(:field, [])
        |> Enum.filter(&(!Enum.member?(@relation_keys, &1.type |> String.to_atom())))
      )
      |> Enum.filter(&Map.get(&1, :create, true))
      |> Enum.map(&Map.get(&1, :name))

    if plugin_enabled?(object, :password) do
      origin_fields -- ["password_digest"]
    else
      origin_fields
    end
    |> Enum.map(&String.to_atom/1)
    |> Unit.new()
  end

  def update_fields(object) do
    origin_fields =
      object
      |> Map.get(:schema, [])
      |> Enum.filter(&Map.get(&1, :virtual, false))
      |> Kernel.++(
        object
        |> QMap.get(:field, [])
        |> Enum.filter(&(!Enum.member?(@relation_keys, &1.type |> String.to_atom())))
      )
      |> Enum.filter(&Map.get(&1, :update, true))
      |> Enum.map(&Map.get(&1, :name))

    if plugin_enabled?(object, :password) do
      Enum.filter(origin_fields, &(!String.contains?(&1, "password")))
    else
      origin_fields
    end
    |> Enum.map(&String.to_atom/1)
    |> Unit.new()
  end
end
