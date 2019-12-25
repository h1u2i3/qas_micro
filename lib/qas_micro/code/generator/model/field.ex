defmodule QasMicro.Code.Generator.Model.Field do
  import QasMicro.Util.Helper

  alias QasMicro.Util.Map, as: QMap
  alias QasMicro.Util.Sigil, as: QSigil

  # the options keys from ecto document
  @options_keys [:default, :source, :autogenerate, :read_after_writes, :virtual, :primary_keys]
  # relation keys can be used in qas
  @relation_keys [:has_many, :many_to_many, :has_one, :belongs_to, :embeds_one, :embeds_many]

  def render(object) do
    schema = Map.get(object, :schema, [])
    schema_names = get_value_from_map_list(schema, :name)
    schema_foreign_keys = get_value_from_map_list(schema, :foreign_key)
    schema_targets = get_value_from_map_list(schema, :target)

    object
    |> QMap.get(:field, [])
    |> add_plugin_fields(object)
    |> Enum.filter(
      &filter_with_relation_field(&1, schema_names, schema_targets, schema_foreign_keys)
    )
    |> Kernel.++(Map.get(object, :schema, []))
    # |> Kernel.++([
    #   %{name: "row_number", type: "integer", virtual: true},
    #   %{name: "through_key", type: "string", virtual: true}
    # ])
    |> Enum.map(&render_single/1)
    |> Enum.filter(& &1)
  end

  def render_single(field) do
    field
    |> arange_attributes
    |> render_to_string
  end

  defp filter_with_relation_field(item, schema_names, schema_targets, schema_foreign_keys) do
    item_name = item.name
    origin_name = String.replace(item_name, ~r/_id$/, "")

    !(origin_name in schema_names ||
        origin_name in schema_targets ||
        item_name in schema_foreign_keys)
  end

  defp get_value_from_map_list(list, key) do
    list
    |> Enum.map(&Map.get(&1, key))
    |> Enum.filter(& &1)
    |> Enum.uniq()
  end

  defp add_plugin_fields(fields, object) do
    object
    |> QMap.get(:plugin, [])
    |> Enum.reduce(fields, fn
      {:wechat, true}, acc -> [%{name: "wechat_digest", type: "string"} | acc]
      {:password, true}, acc -> [%{name: "password_digest", type: "string"} | acc]
      {:unique_number, true}, acc -> [%{name: "unique_number", type: "string"} | acc]
      _, acc -> acc
    end)
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
      :text -> acc |> QMap.put(:type, :string)
      :geometry -> QMap.put(acc, :type, Geo.PostGIS.Geometry)
      type when type in [:file, :json] -> QMap.put(acc, :type, :map)
      type when type in [:jsons, :files] -> QMap.put(acc, :type, {:array, :map})
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
end
