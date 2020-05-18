defmodule QasMicro.Generator.Database.Field do
  import QasMicro.Util.Helper

  alias QasMicro.Util.Map, as: QMap
  alias QasMicro.Util.Sigil, as: QSigil

  # will be effect in some other part of render
  # but should be removed in fied render
  @plugin_settings [:update, :create, :role, :filter, :index, :unique]
  @relation_keys ["belongs_to", "has_many", "has_one"]

  @plugin_fields %{
    password: %{name: "password_digest", type: "string"}
  }

  @config_fields %{
    am_authority: %{name: "am_authority", type: "text"},
    soft_delete: %{name: "deleted_at", type: "int64"}
  }

  def render(object, config_module) do
    object
    |> filter_fields()
    |> add_config_fields(config_module)
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
    |> Enum.filter(&(!Enum.member?(@relation_keys, &1.type)))
    |> Enum.filter(&(!Map.get(&1, :virtual, false)))
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
      :int64 ->
        acc |> QMap.put(:type, :integer) |> QMap.put(:"meta.type", :bigint)

      type when type in [:geometry] ->
        QMap.put(acc, :type, Geo.PostGIS.Geometry)

      type when type in [:text, :file, :files] ->
        acc |> QMap.put(:type, :string) |> QMap.put(:"meta.type", :text)

      type when type in [:json, :jsons] ->
        QMap.put(acc, :type, :json)

      _ ->
        QMap.put(acc, :type, type)
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
