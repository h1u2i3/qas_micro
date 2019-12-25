defmodule Elixir.QasApp.Account.Plugin.Model.Login do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto.Query
      import Geo.PostGIS
      import QasMicro.Util.Sigil
      import QasMicro.Util.Helper

      alias Elixir.QasApp.Account.Repo

      schema "logins" do
        field(:organization_id, :integer)
        field(:user_id, :integer)
        field(:username, :string)
        field(:role, :string)
        timestamps(inserted_at: :created_at)
      end

      @create_fields [:organization_id, :user_id, :username, :role]
      @update_fields [:organization_id, :user_id, :username, :role]

      def create_changeset(struct, params \\ %{}, _role \\ :visitor) do
        struct
        |> Ecto.Changeset.cast(params, @create_fields)
      end

      def update_changeset(struct, params \\ %{}, _role \\ :visitor) do
        struct
        |> Ecto.Changeset.change()
        |> Ecto.Changeset.cast(params, @update_fields)
      end

      # return empty struct
      def new do
        %__MODULE__{}
      end

      def all_fields do
        [:organization_id, :user_id, :username, :role]
      end

      def create_fields do
        [:organization_id, :user_id, :username, :role]
      end

      def update_fields do
        [:organization_id, :user_id, :username, :role]
      end

      defoverridable Module.definitions_in(__MODULE__, :def)
    end
  end
end