defmodule QasMicro.Generator.Model.Validation do
  import QasMicro.Util.Helper

  alias QasMicro.Util.Map, as: QMap
  alias QasMicro.Util.Sigil, as: QSigil
  alias QasMicro.Generator.Model.Validator

  def render(object) do
    object
    |> Map.get(:validation, [])
    |> Enum.reduce(%{create: [], update: []}, &render_single/2)
  end

  def render_single(item, acc) do
    module = Validator
    function = :validation_generator

    {create_needed, item1} = Map.pop(item, :create, false)
    {update_needed, item2} = Map.pop(item1, :update, false)
    {args_map, options_map} = Map.split(item2, [:type, :name, :data])

    cast_options_map =
      options_map
      |> Enum.map(fn {k, v} -> {k, QSigil.parse(v)} end)
      |> Enum.into(%{})

    validation_name = String.to_atom("validate_#{args_map |> QMap.get(:type)}")
    validation_field = args_map |> QMap.get(:name) |> QSigil.to_atom()
    validation_data = args_map |> QMap.get(:data) |> QSigil.to_atom()

    validation =
      if validation_data do
        apply(module, function, [
          validation_name,
          [validation_field, validation_data, map_to_keyword(cast_options_map)]
        ])
      else
        apply(module, function, [
          validation_name,
          [validation_field, map_to_keyword(cast_options_map)]
        ])
      end

    acc
    |> update_acc(:create, create_needed, validation)
    |> update_acc(:update, update_needed, validation)
  end

  defp update_acc(acc, action, needed, validation) do
    if needed do
      Map.put(acc, action, [validation | Map.get(acc, action)])
    else
      acc
    end
  end
end
