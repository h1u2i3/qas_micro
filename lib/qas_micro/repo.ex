defmodule QasMicro.Repo do
  @doc """
  Soft deletes all entries matching the given query.
  It returns a tuple containing the number of entries and any returned
  result as second element. The second element is `nil` by default
  unless a `select` is supplied in the update query.
  ## Examples
      MyRepo.soft_delete_all(Post)
      from(p in Post, where: p.id < 10) |> MyRepo.soft_delete_all()
  """
  @callback soft_delete_all(queryable :: Ecto.Queryable.t()) :: {integer, nil | [term]}

  @doc """
  Soft deletes a struct.
  Updates the `deleted_at` field with the current datetime in UTC.
  It returns `{:ok, struct}` if the struct has been successfully
  soft deleted or `{:error, changeset}` if there was a validation
  or a known constraint error.
  ## Examples
      post = MyRepo.get!(Post, 42)
      case MyRepo.soft_delete post do
        {:ok, struct}       -> # Soft deleted with success
        {:error, changeset} -> # Something went wrong
      end
  """
  @callback soft_delete(struct_or_changeset :: Ecto.Schema.t() | Ecto.Changeset.t()) ::
              {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @doc """
  Same as `c:soft_delete/1` but returns the struct or raises if the changeset is invalid.
  """
  @callback soft_delete!(struct_or_changeset :: Ecto.Schema.t() | Ecto.Changeset.t()) ::
              Ecto.Schema.t()

  defmacro __using__(_opts) do
    quote do
      def soft_delete_all(queryable) do
        update_all(queryable, set: [deleted_at: utc_now()])
      end

      def soft_delete(struct_or_changeset) do
        struct_or_changeset
        |> Ecto.Changeset.change(deleted_at: utc_now())
        |> update()
      end

      def soft_delete!(struct_or_changeset) do
        struct_or_changeset
        |> Ecto.Changeset.change(deleted_at: utc_now())
        |> update!()
      end

      defp utc_now do
        :os.system_time(:milli_seconds)
      end
    end
  end
end
