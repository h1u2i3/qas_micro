defmodule Elixir.QasApp.Account.Plugin.Model.Organization do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto.Query
      import Geo.PostGIS
      import QasMicro.Util.Sigil
      import QasMicro.Util.Helper

      alias Elixir.QasApp.Account.Repo

      schema "organizations" do
        field(:name, :string)
        field(:category, :string)
        field(:avatar, :string)
        field(:basic_setting, :map)
        field(:desktop_setting, :map)
        field(:payment_setting, :map)
        timestamps(inserted_at: :created_at)
      end

      @create_fields [
        :name,
        :category,
        :avatar,
        :basic_setting,
        :desktop_setting,
        :payment_setting
      ]
      @update_fields [
        :name,
        :category,
        :avatar,
        :basic_setting,
        :desktop_setting,
        :payment_setting
      ]

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
        [:name, :category, :avatar, :basic_setting, :desktop_setting, :payment_setting]
      end

      def create_fields do
        [:name, :category, :avatar, :basic_setting, :desktop_setting, :payment_setting]
      end

      def update_fields do
        [:name, :category, :avatar, :basic_setting, :desktop_setting, :payment_setting]
      end

      defoverridable Module.definitions_in(__MODULE__, :def)
    end
  end
end