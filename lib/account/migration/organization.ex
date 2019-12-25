defmodule Elixir.QasApp.Account.Migration.Organization do
  use Yacto.Schema, dbname: :account_dev

  schema "organizations" do
    field(:name, :string)
    field(:category, :string)
    field(:avatar, :string)
    field(:basic_setting, :map)
    field(:desktop_setting, :map)
    field(:payment_setting, :map)
    timestamps(inserted_at: :created_at, type: :integer)
  end
end