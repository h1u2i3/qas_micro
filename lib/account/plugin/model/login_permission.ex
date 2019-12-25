defmodule Elixir.QasApp.Account.Plugin.Model.LoginPermission do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto.Query
      import Geo.PostGIS
      import QasMicro.Util.Sigil
      import QasMicro.Util.Helper

      alias Elixir.QasApp.Account.Repo

      schema "login_permissions" do
        field(:login_id, :integer)
        field(:permission_setting, :map)
        timestamps(inserted_at: :created_at)
      end

      @create_fields [:login_id, :permission_setting]
      @update_fields [:login_id, :permission_setting]

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
        [:login_id, :permission_setting]
      end

      def create_fields do
        [:login_id, :permission_setting]
      end

      def update_fields do
        [:login_id, :permission_setting]
      end

      defoverridable Module.definitions_in(__MODULE__, :def)
    end
  end
end