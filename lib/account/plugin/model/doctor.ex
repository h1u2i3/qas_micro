defmodule Elixir.QasApp.Account.Plugin.Model.Doctor do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto.Query
      import Geo.PostGIS
      import QasMicro.Util.Sigil
      import QasMicro.Util.Helper

      alias Elixir.QasApp.Account.Repo

      schema "doctors" do
        field(:name, :string)
        field(:hospital, :string)
        field(:title, :string)
        field(:department, :string)
        field(:description, :string)
        field(:organization_id, :integer)
        timestamps(inserted_at: :created_at)
      end

      @create_fields [:name, :hospital, :title, :department, :description, :organization_id]
      @update_fields [:name, :hospital, :title, :department, :description, :organization_id]

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
        [:name, :hospital, :title, :department, :description, :organization_id]
      end

      def create_fields do
        [:name, :hospital, :title, :department, :description, :organization_id]
      end

      def update_fields do
        [:name, :hospital, :title, :department, :description, :organization_id]
      end

      defoverridable Module.definitions_in(__MODULE__, :def)
    end
  end
end