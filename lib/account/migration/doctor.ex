defmodule Elixir.QasApp.Account.Migration.Doctor do
  use Yacto.Schema, dbname: :account_dev

  schema "doctors" do
    field(:name, :string)
    field(:hospital, :string)
    field(:title, :string)
    field(:department, :string)
    field(:description, :string)
    field(:organization_id, :integer)
    timestamps(inserted_at: :created_at, type: :integer)
  end
end