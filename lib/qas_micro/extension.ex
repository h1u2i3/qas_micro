defmodule QasMicro.Extension do
  defmacro __using__(extension) do
    case extension do
      :model ->
        quote do
          import Ecto.Query

          # used to define special all query when the basic setting is not enough
          def plural_args(args, _), do: args

          # common plural origin query, which is useful for some special data
          def origin_query, do: __MODULE__

          def origin_query(%Absinthe.Resolution{context: context} = res) do
            context.global_module.origin_query(__MODULE__, origin_query(), res)
          end

          def origin_query(_res), do: origin_query()

          def origin_query(_, _), do: __MODULE__

          # used to define single query args when the basic setting is not enough
          def single_args(args, _), do: args

          # used to define complex action permission
          def can?(_action, _changeset, _current_user), do: :ok

          # used to define relation access permission
          def can?(_parent, _relation, _role, _current_user), do: true

          # get the field can update with role
          def role_create_input_fields(fields, _role), do: fields

          def role_update_input_fields(fields, _role), do: fields

          def role_output_forbidden_fields(_role), do: []

          # default sms send method
          def send_sms(_cellphone, _data),
            do: raise("you should add your own implement for send_sms method")

          # generate unique number for plugin
          def generate_unique_number(changeset) do
            Ecto.Changeset.put_change(
              changeset,
              :unique_number,
              "#{Enum.random(10000..99999)}#{:os.system_time(:seconds)}"
            )
          end

          # special deal with query filter paginate
          def paginate_with(query, pagination) do
            if is_nil(pagination) || Enum.empty?(pagination) do
              query
            else
              offset = Map.get(pagination, :offset, 0)
              limit = Map.get(pagination, :limit, 10)
              from(q in query, limit: ^limit, offset: ^offset)
            end
          end

          def order_with(query, _item), do: query

          def filter_with(query, _item), do: query
        end

      :schema ->
        quote do
        end

      :resolver ->
        quote do
        end
    end
  end
end
