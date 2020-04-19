defmodule QasMicro.Generator.Model do
  use QasMicroGenetator.Template

  alias QasMicro.Util.Unit
  alias QasMicro.Util.Map, as: QMap

  @external_resource Path.join(__DIR__, "model/model.eex")
  @relation_keys ["has_many", "has_one", "belongs_to", "index"]

  def render(config_module, object) do
    object_name = object.name

    soft_delete = config_module.soft_delete()
    am_authority = config_module.am_authority()

    table_name = Map.get(object, :table_name, Inflex.pluralize(object_name))
    timestamp = Map.get(object, :timestamp, true)
    polymorphic = Map.get(object, :polymorphic, false)
    join_table = Map.get(object, :join_table, false)
    password = Map.get(object, :password, false)
    unique_number = Map.get(object, :unique_number, false)
    geometry = Map.get(object, :geometry, false)

    am_authority_field =
      if field = Map.get(object, :am_authority) do
        String.to_atom(field)
      else
        nil
      end

    application_name = config_module.name()
    repo_module = config_module.repo_module()
    uuid_module = config_module.uuid_module()
    model_module = config_module.model_module(object_name)
    model_plugin_module = config_module.plugin_model_module(object_name)

    field_schema = QasMicro.Generator.Model.Field.render(config_module, object)
    # TODO
    # No need with the relationship between models
    # we use dataloader to handle relationship in qas_rpc
    relation_schema = QasMicro.Generator.Model.Relation.render(config_module, object)
    validations = QasMicro.Generator.Model.Validation.render(object)

    all_fields = all_fields(object)
    create_fields = create_fields(object, am_authority)
    update_fields = update_fields(object)

    # Add special handling for many_to_many relationships
    many_to_many_fields = many_to_many_fields(config_module, object)

    eex_template_string()
    |> EEx.eval_string(
      # soft delete
      soft_delete: soft_delete,
      # modules
      config_module: config_module,
      uuid_module: uuid_module,
      model_module: model_module,
      model_plugin_module: model_plugin_module,
      repo_module_name: repo_module,
      # names
      application_name: application_name,
      object_name: object_name,
      table_name: table_name,
      # schema
      field_schema: field_schema,
      # TODO
      relation_schema: relation_schema,
      timestamp: timestamp,
      join_table: join_table,
      # the fields
      all_fields: all_fields,
      create_fields: create_fields,
      update_fields: update_fields,
      many_to_many_fields: many_to_many_fields,
      am_authority_field: am_authority_field,
      join_tables: join_tables(object),
      # field validations
      create_validation: Map.get(validations, :create, []),
      update_validation: Map.get(validations, :update, []),
      # plugin
      password: password,
      unique_number: unique_number,
      polymorphic: polymorphic,
      geometry: geometry
    )
    |> config_module.save_file("#{object_name}.ex", "plugin/model")

    QasMicro.Generator.Model.Plugin.render(
      config_module,
      object_name,
      model_module,
      model_plugin_module,
      polymorphic
    )
  end

  defp all_fields(object) do
    object
    |> QMap.get(:field, [])
    |> Enum.filter(&(!Enum.member?(@relation_keys, &1.type)))
    |> Enum.filter(&(!Map.get(&1, :virtual, false)))
    |> Enum.map(&String.to_atom(&1.name))
    |> Unit.new()
  end

  defp create_fields(object, am_authority) do
    origin_fields =
      object
      |> QMap.get(:field, [])
      |> Enum.filter(&(!Enum.member?(@relation_keys, &1.type)))
      |> Enum.filter(&Map.get(&1, :create, true))
      |> Enum.map(&Map.get(&1, :name))
      |> Kernel.++(if(am_authority, do: ["am_authority"], else: []))

    if Map.get(object, :password, false) do
      (origin_fields -- ["password_digest"]) ++ ["password"]
    else
      origin_fields
    end
    |> Enum.map(&String.to_atom/1)
    |> Unit.new()
  end

  defp update_fields(object) do
    origin_fields =
      object
      |> QMap.get(:field, [])
      |> Enum.filter(&(!Enum.member?(@relation_keys, &1.type)))
      |> Enum.filter(&Map.get(&1, :update, true))
      |> Enum.map(&Map.get(&1, :name))

    if Map.get(object, :password, false) do
      Enum.filter(origin_fields, &(!String.contains?(&1, "password")))
    else
      origin_fields
    end
    |> Enum.map(&String.to_atom/1)
    |> Unit.new()
  end

  defp join_tables(object) do
    object
    |> Map.get(:field, [])
    |> Enum.filter(&(Map.get(&1, :type) == "has_many" && Map.get(&1, :many_to_many)))
    |> Enum.map(&{&1.many_to_many, &1.name})
  end

  defp many_to_many_fields(config_module, object) do
    # TODO:
    # Because it reversed, so in model, we did not to get the target model
    # We should provide the methods to make other get this model
    # So, must remember
    m2m_fields =
      object
      |> Map.get(:field, [])
      |> Enum.filter(&(Map.get(&1, :type) == "has_many" && Map.get(&1, :many_to_many)))

    if Enum.empty?(m2m_fields) do
      nil
    else
      m2m_fields
      |> Enum.map(fn item ->
        {
          # And here we just use the _id to be the key, no need to be other ones
          String.to_atom("#{Map.get(item, :name)}_ids"),
          item |> Map.get(:many_to_many) |> config_module.model_module
        }
      end)
      |> Enum.into(%{})
      |> Unit.new()
    end
  end
end
