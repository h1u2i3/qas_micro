defmodule Elixir.QasApp.Account.Repo do
  use Ecto.Repo, otp_app: :qas, adapter: Ecto.Adapters.Postgres
end