defmodule QasMicro.Generator.Model.Validator do
  @moduledoc """
  Model validator template generator
  """
  def validation_generator(:validate_unique, [fields, options]) do
    options =
      if key = Keyword.get(options, :key) do
        Keyword.put(options, :name, key)
      else
        options
      end

    fields
    |> List.wrap()
    |> Enum.map(
      &(:unique_constraint
        |> validation_ast([&1, Keyword.drop(options, [:key])])
        |> Macro.to_string())
    )
    |> Enum.join(" ")
  end

  def validation_generator(:validate_status, [field | [statuses | _rest]]) do
    status_validation_generator(field, statuses)
  end

  def validation_generator(:validate_assoc, [fields, options]) do
    fields
    |> List.wrap()
    |> Enum.map(&(:assoc_constraint |> validation_ast([&1, options]) |> Macro.to_string()))
    |> Enum.join(" ")
  end

  def validation_generator(method, args) do
    method
    |> validation_ast(args)
    |> Macro.to_string()
  end

  defp status_validation_generator(field, statuses) do
    [
      validation_ast(:validate_inclusion, [field, statuses]),
      validation_fn_ast(:validate_change, [field, status_check_fn_ast(field, statuses)])
    ]
    |> pipe_ast
    |> Macro.to_string()
  end

  defp status_check_fn_ast(field, statuses) do
    quote do
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
    end
  end

  defp pipe_ast(args) when not is_list(args) do
    pipe_ast([args])
  end

  defp pipe_ast(args) do
    {:|>, [context: Elixir, import: Kernel], args}
  end

  defp validation_ast(method, args) do
    method
    |> validation_fn_ast(args)
    |> pipe_ast
  end

  defp validation_fn_ast(method, args) do
    {
      {:., [], [{:__aliases__, [alias: false], [:Ecto, :Changeset]}, method]},
      [],
      args
    }
  end
end
