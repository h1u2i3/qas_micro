defmodule QasMicro.Query do
  import Ecto.Query

  def plural_query_reducer(module) do
    fn arg, query ->
      case arg do
        {:order, order} ->
          if order do
            query |> order_with(order, module)
          else
            query
          end

        {:filter, filter} ->
          if filter do
            query |> filter_with(filter, module)
          else
            query
          end

        {:paginate, paginate} ->
          if paginate do
            query |> paginate_with(paginate, module)
          else
            query
          end
      end
    end
  end

  def filter_with(query, filter, module) do
    filter
    |> Map.drop([:__struct__])
    |> Enum.reduce(query, fn {key, item}, query ->
      handle_with_filter(module, query, key, item)
    end)
  end

  def paginate_with(query, paginate, module) do
    module.paginate_with(query, paginate)
  end

  def order_with(query, order, module) do
    Enum.reduce(order, query, fn order_item, query ->
      order = Map.get(order_item, :order, :ASC)
      name = String.to_atom(Map.get(order_item, :name, "id"))

      case order do
        :ASC ->
          from(q in query, order_by: [asc: field(q, ^name)])

        :DESC ->
          from(q in query, order_by: [desc: field(q, ^name)])

        :SPECIAL ->
          module.order_with(query, name)
      end
    end)
  end

  defp handle_with_filter(module, query, key, item) do
    case Jason.decode(item, keys: :atoms) do
      {:ok, item_json} ->
        item_json
        |> List.wrap()
        |> Enum.reduce(query, fn cast_item, query ->
          if key == :custom do
            module.filter_with(query, cast_item)
          else
            case cast_item do
              %{cond: "like", value: value} ->
                from(q in query, where: ilike(field(q, ^key), ^"%#{value}%"))

              %{cond: "eq", value: value} ->
                from(q in query, where: field(q, ^key) == ^value)

              %{cond: "lt", value: value} ->
                from(q in query, where: field(q, ^key) < ^value)

              %{cond: "gt", value: value} ->
                from(q in query, where: field(q, ^key) > ^value)

              %{cond: "in", value: value} ->
                from(q in query, where: field(q, ^key) in ^value)
            end
          end
        end)

      {:error, _} ->
        query
    end
  end

  def ids_filter(query, ids_map) do
    {_, cast_ids_map} = Map.split(ids_map, [:__struct__])

    Enum.reduce(cast_ids_map, query, fn {key, value}, query ->
      if value == nil || Enum.empty?(value) do
        query
      else
        singleton_key =
          key
          |> Atom.to_string()
          |> Inflex.singularize()
          |> String.to_atom()

        from(q in query, where: field(q, ^singleton_key) in ^value)
      end
    end)
  end
end
