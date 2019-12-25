defmodule Elixir.QasApp.Account.Plugin.Model.User do
  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema

      import Ecto.Query
      import Geo.PostGIS
      import QasMicro.Util.Sigil
      import QasMicro.Util.Helper

      alias Elixir.QasApp.Account.Repo

      schema "users" do
        field(:name, :string)
        field(:avatar, :string)
        field(:cellphone, :string)
        field(:wechat_digest, :string)
        timestamps(inserted_at: :created_at)
      end

      @create_fields [:name, :avatar, :cellphone, :wechat_digest]
      @update_fields [:name, :avatar, :cellphone, :wechat_digest]

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
        [:name, :avatar, :cellphone, :wechat_digest]
      end

      def create_fields do
        [:name, :avatar, :cellphone, :wechat_digest]
      end

      def update_fields do
        [:name, :avatar, :cellphone, :wechat_digest]
      end

      defoverridable Module.definitions_in(__MODULE__, :def)
    end
  end
end