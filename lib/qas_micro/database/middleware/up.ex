defmodule QasMicro.Database.Middleware.Up do
  alias QasCore.Pipeline

  require Logger

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    repo = config_module.repo_module()
    adapter = repo.__adapter__

    # set the database up
    case adapter.storage_up(repo.config) do
      :ok ->
        Logger.info("The database is up!")

      {:error, :already_up} ->
        Logger.info("The database is already up!")

      _ ->
        raise("Can't create database!")
    end

    pipeline
  end
end
