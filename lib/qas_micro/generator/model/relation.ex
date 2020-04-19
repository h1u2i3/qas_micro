defmodule QasMicro.Generator.Model.Relation do
  import QasMicro.Util.Helper

  alias QasMicro.Util.Map, as: QMap
  alias QasMicro.Util.Sigil, as: QSigil

  # relation keys can be used in qas
  @relation_keys [:has_many, :many_to_many, :has_one, :belongs_to, :embeds_one, :embeds_many]

  def render(config_module, object) do
    if quick_test_mode() do
      []
    else
      object
      |> Map.get(:field, [])
      |> Enum.filter(&Enum.member?(@relation_keys, &1.type |> String.to_atom()))
      |> Enum.filter(&(!Map.get(&1, :struct) && !Map.get(&1, :polymorphic, false)))
      |> Enum.map(&render_single(config_module, &1))
    end
  end

  def render_single(config_module, field) do
    map = arrange_attributes(field, config_module)

    case map do
      %{through: _through} -> render_to_through_string(map)
      _ -> render_to_string(map)
    end
  end

  defp arrange_attributes(field, config_module) do
    {type, cast_field} = Map.pop(field, :type)

    cast_type =
      if Map.get(cast_field, :many_to_many) do
        :many_to_many
      else
        String.to_atom(type)
      end

    init_map = QMap.put(%{}, :type, cast_type)

    Enum.reduce(cast_field, init_map, fn
      {:name, name}, acc ->
        cast_acc =
          cast_type
          |> case do
            t when t in [:has_many, :many_to_many, :embeds_many] ->
              QMap.put(acc, :name, name |> Inflex.pluralize() |> String.to_atom())

            t when t in [:has_one, :belongs_to, :embeds_one] ->
              QMap.put(acc, :name, String.to_atom(name))

            _ ->
              acc
          end

        target_name = Map.get(cast_field, :target) || name

        case Map.get(cast_field, :polymorphic) do
          nil ->
            QMap.put(cast_acc, :target, config_module.model_module(target_name))

          table_name ->
            QMap.put(cast_acc, :target, {table_name, config_module.model_module(target_name)})
        end

      {:target, _}, acc ->
        acc

      {:polymorphic, _}, acc ->
        acc

      {:join_method, _}, acc ->
        acc

      {:fetch_way, _}, acc ->
        acc

      {:many_to_many, table}, acc ->
        QMap.put(acc, :join_through, table)

      {key, value}, acc ->
        QMap.put(acc, key, QSigil.to_atom(value))
    end)
  end

  @extra_keys [:name, :target, :type, :key, :many_to_many]
  defp render_to_string(%{type: type} = attributes) when type in @relation_keys do
    {type, [], []}
    |> pipe_into(0, QMap.get(attributes, :name))
    |> pipe_into(1, QMap.get(attributes, :target))
    |> pipe_into(2, attributes |> QMap.drop(@extra_keys) |> map_to_keyword)
    |> Macro.to_string()
  end

  defp render_to_string(_), do: nil

  defp render_to_through_string(%{type: type} = attributes) when type in @relation_keys do
    {type, [], []}
    |> pipe_into(0, QMap.get(attributes, :name))
    |> pipe_into(1, attributes |> QMap.drop(@extra_keys) |> map_to_keyword)
    |> Macro.to_string()
  end

  defp render_to_through_string(_), do: nil

  defp quick_test_mode do
    System.get_env("QUICK_TEST") || false
  end
end
