use Mix.Config

config :qas_micro, QasApp.Account.Repo,
  username: "postgres",
  hostname: "localhost",
  database: "account_dev",
  extensions: [{Geo.PostGIS.Extension, library: Geo}],
  type: QasMicro.PostgresTypes,
  show_sensitive_data_on_connection_error: true

config :yacto, :databases, %{
  account_dev: %{
    module: Yacto.DB.Single,
    repo: QasApp.Account.Repo
  }
}
