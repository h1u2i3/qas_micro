defmodule QasMicro.Generator.Database.Field do
  import QasMicro.Util.Helper

  alias QasMicro.Util.Map, as: QMap
  alias QasMicro.Util.Sigil, as: QSigil

  # will be effect in some other part of render
  # but should be removed in fied render
  @plugin_settings [:update, :create, :role, :filter, :index, :unique]
  @relation_keys [:belongs_to, :has_many, :has_one]

  def render(object) do
    object
    |> filter_fields()
    |> add_plugin_fields(object)
    |> Enum.map(&render_single/1)
    |> Enum.filter(& &1)
  end

  def render_single(field) do
    field
    |> remove_pulgin_setting
    |> arange_attributes
    |> render_to_string
  end

  defp filter_fields(object) do
    object
    |> QMap.get(:field, [])
    |> Enum.filter(&(!Enum.member?(@relation_keys, String.to_atom(&1.type))))
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

  defp remove_pulgin_setting(field) do
    field
    |> Enum.filter(&(!Enum.member?(@plugin_settings, elem(&1, 0))))
    |> Enum.into(%{})
  end

  defp arange_attributes(field) do
    Enum.reduce(field, %{}, fn
      {:name, name}, acc -> QMap.put(acc, :name, String.to_atom(name))
      {:type, type}, acc -> type |> String.to_atom() |> handle_field_type(acc)
      {:default, default}, acc -> QMap.put(acc, :default, QSigil.parse(default))
      {key, value}, acc -> QMap.put(acc, :"meta.#{key}", QSigil.parse(value))
    end)
  end

  defp handle_field_type(type, acc) do
    case type do
      :text -> acc |> QMap.put(:type, :string) |> QMap.put(:"meta.type", :text)
      type when type in [:geometry] -> QMap.put(acc, :type, Geo.PostGIS.Geometry)
      type when type in [:file, :json] -> QMap.put(acc, :type, :map)
      type when type in [:jsons, :files] -> QMap.put(acc, :type, {:array, :map})
      _ -> QMap.put(acc, :type, type)
    end
  end

  defp render_to_string(%{type: :index}), do: nil

  defp render_to_string(attributes) do
    {:field, [], []}
    |> pipe_into(0, QMap.get(attributes, :name))
    |> pipe_into(1, QMap.get(attributes, :type))
    |> pipe_into(2, attributes |> QMap.drop([:name, :type]) |> map_to_keyword)
    |> Macro.to_string()
  end
end
