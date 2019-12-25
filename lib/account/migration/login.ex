defmodule Elixir.QasApp.Account.Migration.Login do
  use Yacto.Schema, dbname: :account_dev

  schema "logins" do
    field(:organization_id, :integer)
    field(:user_id, :integer)
    field(:username, :string)
    field(:role, :string)
    timestamps(inserted_at: :created_at, type: :integer)
  end
end