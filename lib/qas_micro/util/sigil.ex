defmodule QasMicro.Util.Sigil do
  # other just use Kernel setting
  # float
  defmacro sigil_f(term, _modifiers) do
    quote do
      unquote(term) |> String.to_float()
    end
  end

  # integer
  defmacro sigil_i(term, _modifiers) do
    quote do
      unquote(term) |> String.to_integer()
    end
  end

  # atom array
  defmacro sigil_a(term, _modifiers) do
    quote do
      unquote(term) |> String.split(",") |> Enum.map(&String.to_atom/1)
    end
  end

  # string array
  defmacro sigil_w(term, _modifiers) do
    quote do
      unquote(term) |> String.split(",")
    end
  end

  @doc false
  def to_atom(string) do
    result = parse(string)

    if is_binary(result) do
      case result do
        "?" <> tail ->
          tail

        _ ->
          String.to_atom(result)
      end
    else
      result
    end
  end

  # we should use / as seprator
  @doc false
  def parse(string) when is_binary(string) do
    cond do
      Regex.match?(~r/^[:~{]/, string) ->
        "[#{string}]"
        |> Code.string_to_quoted!()
        |> Macro.postwalk(fn
          {sigil, context, args} when sigil in [:sigil_i, :sigil_w, :sigil_f, :sigil_a] ->
            {
              sigil,
              context
              |> Keyword.put(:context, __MODULE__)
              |> Keyword.put(:imports, [{2, __MODULE__}]),
              args
            }
            |> Code.eval_quoted()
            |> elem(0)

          {sigil, context, args}
          when sigil in [:sigil_c, :sigil_C, :sigil_s, :sigil_S, :sigil_R, :sigil_s, :sigil_N] ->
            {
              sigil,
              context |> Keyword.put(:context, Elixir) |> Keyword.put(:import, Kernel),
              args
            }
            |> Code.eval_quoted()
            |> elem(0)

          ast ->
            ast
        end)
        |> case do
          [item | []] -> item
          result -> result
        end

      true ->
        string
    end
  end

  def parse(string), do: string

  # [
  #   %Ecto.Query.QueryExpr{
  #     expr: [desc: {{:., [], [{:&, [], [0]}, :name]}, [], []}],
  #     file: "/Users/xiaohui/Work/taozui/ebin/src/taozui/schema.ex",
  #     line: 654,
  #     params: []
  #   },
  #   %Ecto.Query.QueryExpr{
  #   expr: [
  #     desc:
  #       {:fragment, [],
  #        [
  #          raw: "CAST(coalesce(substring(",
  #          expr: {{:., [], [{:&, [], [0]}, :info]}, [], []},
  #          raw: "->>'面积' from '\\d+'), '0') AS integer)"
  #        ]}
  #   ],
  #   file: "/Users/xiaohui/Work/taozui/ebin/src/taozui/model/room.ex",
  #   line: 164,
  #   params: []
  # }
  # ]
  def parse_order_struct(structs) do
    Enum.map(structs, fn %{expr: expr} ->
      [{direction, ast}] = expr

      cast_ast_string =
        ast
        |> Macro.postwalk(fn
          {:expr, expr_ast} ->
            Macro.to_string(expr_ast)

          {:raw, raw_string} ->
            raw_string

          {:fragment, [], fragment_args} ->
            #  ["CAST(coalesce(substring(", "&0.info()", "->>'面积' from '\\d+'), '0') AS integer)"]
            fragment_args
            |> Enum.map(fn item ->
              if Regex.match?(~r/^\&.*\)$/, item) do
                Regex.replace(~r/^\&0\.(.*)\(\)$/, item, "\\1")
              else
                item
              end
            end)
            |> Enum.join()

          sub_ast ->
            sub_ast
        end)
        |> case do
          item when is_binary(item) -> item
          item -> Macro.to_string(item)
        end

      if Regex.match?(~r/^\&.*\)$/, cast_ast_string) do
        Regex.replace(~r/^\&0\.(.*)\(\)$/, cast_ast_string, "\\1")
      else
        cast_ast_string
      end
      |> Kernel.<>(" #{direction |> Atom.to_string() |> String.upcase()}")
    end)
  end

  defmacro generate_fragment_order(list) do
    quote do
      Enum.map(unquote(list), fn string ->
        fragment(string)
      end)
    end
  end
end
