defmodule Elixir.QasApp.Account.Migration.LoginPermission do
  use Yacto.Schema, dbname: :account_dev

  schema "login_permissions" do
    field(:login_id, :integer)
    field(:permission_setting, :map)
    timestamps(inserted_at: :created_at, type: :integer)
  end
end