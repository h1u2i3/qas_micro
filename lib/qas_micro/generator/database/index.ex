defmodule QasMicro.Generator.Database.Index do
  import QasMicro.Util.Helper

  alias QasMicro.Util.Map, as: QMap
  alias QasMicro.Util.Sigil, as: QSigil

  @relation_keys ["belongs_to", "has_many", "has_one"]

  def render(object, config_module) do
    am_authority = config_module.am_authority()
    table_name = Map.get(object, :table_name, Inflex.pluralize(object.name))

    object
    |> Map.get(:field, [])
    |> Enum.filter(&(!Enum.member?(@relation_keys, &1.type)))
    |> Enum.filter(&(!Map.get(&1, :virtual, false)))
    |> Kernel.++(if(am_authority, do: [%{type: "index", name: "am_authority"}], else: []))
    |> Enum.map(&render_single(&1, table_name))
    |> Enum.filter(& &1)
  end

  def render_single(field, table_name) do
    field
    |> extract_index_field(table_name)
    |> render_to_string
  end

  defp extract_index_field(field, table_name) do
    Enum.reduce(field, %{}, fn
      {:type, "index"}, acc ->
        QMap.put(acc, :type, :index)

      {:index, true}, acc ->
        QMap.put(acc, :type, :index)

      {:name, name}, acc ->
        acc
        |> QMap.put(:field, QSigil.to_atom(name))
        |> QMap.put(
          :name,
          :"#{table_name}_#{
            name |> QSigil.to_atom() |> List.wrap() |> List.flatten() |> Enum.join("_")
          }"
        )

      {:unique, true}, acc ->
        QMap.put(acc, :unique, true)

      _, acc ->
        acc
    end)
  end

  def render_to_string(%{type: :index} = attributes) do
    {:index, [], []}
    |> pipe_into(0, Map.get(attributes, :field))
    |> pipe_into(1, attributes, fn attrs ->
      %{}
      |> QMap.put_non_null(:unique, Map.get(attrs, :unique))
      |> QMap.put_non_null(:name, Map.get(attrs, :name))
      |> map_to_keyword
    end)
    |> Macro.to_string()
  end

  def render_to_string(_), do: nil
end
