defmodule Elixir.QasApp.Account.Migration.User do
  use Yacto.Schema, dbname: :account_dev

  schema "users" do
    field(:name, :string)
    field(:avatar, :string)
    field(:cellphone, :string)
    field(:wechat_digest, :string)
    timestamps(inserted_at: :created_at, type: :integer)
  end
end