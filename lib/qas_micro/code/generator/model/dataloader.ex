defmodule QasMicro.Code.Generator.Model.Dataloader do
  import QasMicro.Util.Helper

  @relation_keys [:has_many, :many_to_many, :has_one, :belongs_to, :embeds_one, :embeds_many]

  def render(config_module, object) do
    items =
      object
      |> Map.get(:schema, [])
      |> Enum.filter(&Enum.member?(@relation_keys, &1 |> Map.get(:type) |> String.to_atom()))

    Enum.map(items, &render_single_with_relation(config_module, object.name, &1)) ++
      Enum.uniq(Enum.map(items, &render_single_without_relation(config_module, object.name, &1)))
  end

  defp render_single_without_relation(config_module, _model_name, item) do
    relation_module_name = Map.get(item, :target) || get_value_or_raise(item, :name)
    relation_module = config_module.model_module(relation_module_name)
    schema_module = config_module.schema_module()

    """
    def query(#{relation_module}, args) do
      #{schema_module}.#{Inflex.pluralize(relation_module_name)}_query(args)
    end
    """
  end

  defp render_single_with_relation(config_module, model_name, item) do
    relation_module_name = Map.get(item, :target) || get_value_or_raise(item, :name)

    relation_name =
      case item.type |> String.to_atom() do
        name when name in [:has_one, :belongs_to, :embeds_one] ->
          get_value_or_raise(item, :name)

        _ ->
          Inflex.pluralize(get_value_or_raise(item, :name))
      end

    foreign_key = Map.get(item, :foreign_key) || "#{model_name}_id"

    relation_module = config_module.model_module(relation_module_name)
    schema_module = config_module.schema_module()

    # TODO: make this method more simple
    sub_query =
      if join_method = Map.get(item, :join_method) do
        """
        (fn query ->
          sub =
            try do
              #{join_method}
            catch
              error -> raise(error)
            end

          from(
            q in subquery(sub),
            select_merge: %{
              row_number: over(
                row_number(),
                partition_by: q.through_key
              )
            }
          )
        end).(query)
        """
      else
        """
        (fn ->
          from(
            q in query,
            select_merge: %{
              row_number: over(
                row_number(),
                partition_by: q.#{foreign_key}
              )
            }
          )
        end).()
        """
      end

    """
    def query({:#{relation_name}, #{relation_module}}, %{qas_fetch_way: :special} = args) do
      cast_args = Map.drop(args, [:qas_fetch_way])
      {pagination_args, other_args} = Map.split(cast_args, [:pagination])

      query = #{relation_module}.origin_query(:#{relation_name}, __MODULE__)
      sub_query =
        #{sub_query}

      if Enum.empty?(pagination_args) do
        Enum.reduce(
          other_args,
          sub_query,
          #{schema_module}.plural_query_reducer(#{relation_module})
        )
      else
        %{pagination: %{limit: limit, offset: offset}} = pagination_args

        Enum.reduce(
          other_args,
          from(
            q in subquery(sub_query),
            where: q.row_number <= ^(offset + limit) and q.row_number >= ^(offset + 1)
          ),
          #{schema_module}.plural_query_reducer(#{relation_module})
        )
      end
    end

    def query({:#{relation_name}, #{relation_module}}, %{qas_fetch_way: :one_through} = args) do
      cast_args = Map.drop(args, [:qas_fetch_way])
      query = #{relation_module}.origin_query(:#{relation_name}, __MODULE__)
      sub_query =
        #{sub_query}

      Enum.reduce(
        cast_args,
        sub_query,
        #{schema_module}.plural_query_reducer(#{relation_module})
      )
    end

    def query({:#{relation_name}, #{relation_module}}, %{pagination: %{limit: limit, offset: offset}} = args) do
      cast_args = Map.drop(args, [:pagination])
      query = #{relation_module}.origin_query(:#{relation_name}, __MODULE__)

      sub_query =
        #{sub_query}

      Enum.reduce(
        cast_args,
        from(
          q in subquery(sub_query),
          where: q.row_number <= ^(offset + limit) and q.row_number >= ^(offset + 1)
        ),
        #{schema_module}.plural_query_reducer(#{relation_module})
      )
    end

    def query({:#{relation_name}, #{relation_module}}, args) do
      #{schema_module}.#{Inflex.pluralize(relation_module_name)}_query(args)
    end
    """
  end
end
