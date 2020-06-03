defmodule QasMicro.Generator.Model.Field do
  import QasMicro.Util.Helper

  alias QasMicro.Util.Map, as: QMap
  alias QasMicro.Util.Sigil, as: QSigil

  # the options keys from ecto document
  @options_keys [:default, :source, :autogenerate, :read_after_writes, :virtual, :primary_keys]
  # relation keys can be used in qas
  @relation_keys [:has_many, :has_one, :belongs_to]

  @plugin_fields %{
    password: %{name: "password_digest", type: "string"}
  }

  @config_fields %{
    am_authority: %{name: "am_authority", type: "text"},
    soft_delete: %{name: "deleted_at", type: "integer"}
  }

  def render(config_module, object) do
    schema =
      object
      |> Map.get(:field, [])
      |> Enum.filter(&Enum.member?(@relation_keys, String.to_atom(&1.type)))
      |> Enum.filter(&(!Map.get(&1, :struct) && !Map.get(&1, :polymorphic, false)))

    schema_names = get_value_from_map_list(schema, :name)
    schema_foreign_keys = get_value_from_map_list(schema, :foreign_key)
    schema_targets = get_value_from_map_list(schema, :target)

    object
    |> QMap.get(:field, [])
    |> add_config_fields(config_module)
    |> add_plugin_fields(object)
    |> Enum.filter(
      &filter_with_relation_field(&1, schema_names, schema_targets, schema_foreign_keys)
    )
    |> Enum.map(&render_single/1)
    |> Enum.filter(& &1)
  end

  def render_single(field) do
    field
    |> arange_attributes
    |> render_to_string
  end

  defp filter_with_relation_field(item, schema_names, schema_targets, schema_foreign_keys) do
    if quick_test_mode() do
      true
    else
      item_name = item.name
      origin_name = String.replace(item_name, ~r/_id$/, "")

      !(origin_name in schema_names ||
          origin_name in schema_targets ||
          item_name in schema_foreign_keys)
    end
  end

  defp get_value_from_map_list(list, key) do
    list
    |> Enum.map(&Map.get(&1, key))
    |> Enum.filter(& &1)
    |> Enum.uniq()
  end

  defp add_config_fields(fields, config_module) do
    Enum.reduce(@config_fields, fields, fn {key, value}, acc ->
      do_add_config_fields(config_module, acc, key, value)
    end)
  end

  defp add_plugin_fields(fields, object) do
    Enum.reduce(@plugin_fields, fields, fn {key, value}, acc ->
      do_add_plugin_fields(object, acc, key, value)
    end)
  end

  defp do_add_config_fields(config_module, fields, config_name, add_field) do
    if apply(config_module, config_name, []) do
      [add_field | fields]
    else
      fields
    end
  end

  defp do_add_plugin_fields(object, fields, plugin, add_field) do
    if Map.get(object, plugin, false) do
      [add_field | fields]
    else
      fields
    end
  end

  defp arange_attributes(field) do
    Enum.reduce(field, %{}, fn
      {:name, name}, acc ->
        QMap.put(acc, :name, String.to_atom(name))

      {:type, type}, acc ->
        type |> String.to_atom() |> handle_field_type(acc)

      {:default, default}, acc ->
        QMap.put(acc, :default, QSigil.parse(default))

      {key, value}, acc ->
        cond do
          key in @options_keys ->
            QMap.put(acc, key, QSigil.parse(value))

          true ->
            acc
        end
    end)
  end

  defp handle_field_type(type, acc) do
    case type do
      :int64 -> QMap.put(acc, :type, :integer)
      :geometry -> QMap.put(acc, :type, Geo.PostGIS.Geometry)
      type when type in [:text] -> QMap.put(acc, :type, :string)
      type when type in [:decimal] -> QMap.put(acc, :type, QasMicro.Decimal)
      type when type in [:file, :json] -> QMap.put(acc, :type, QasMicro.Json)
      type when type in [:jsons, :files] -> QMap.put(acc, :type, QasMicro.JsonArray)
      _ -> QMap.put(acc, :type, type)
    end
  end

  defp render_to_string(%{type: :index}), do: nil

  defp render_to_string(%{type: type}) when type in @relation_keys, do: nil

  defp render_to_string(attributes) do
    {:field, [], []}
    |> pipe_into(0, QMap.get(attributes, :name))
    |> pipe_into(1, QMap.get(attributes, :type))
    |> pipe_into(2, attributes |> QMap.drop([:name, :type]) |> map_to_keyword)
    |> Macro.to_string()
  end

  defp quick_test_mode do
    System.get_env("QUICK_TEST") || false
  end
end
