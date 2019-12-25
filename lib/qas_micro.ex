defmodule QasMicro do
  alias QasMicro.Database.Worker, as: DatabaseWorker

  require Logger

  @doc """
  Generate codes for app
  """
  def generate(app) do
  end

  @doc """
  Remove qas api database
  """
  def remove_db(app) do
    DatabaseWorker.down({:app, app})
  end

  @doc """
  Seed qas api database
  """
  def seed_db(app) do
    DatabaseWorker.seed({:app, app})
  end

  def handle_success(_pipeline), do: Logger.info("Start api successful")

  def handle_error(_pipeline, reason),
    do: Logger.info("Start api failed, reason: #{inspect(reason)}")
end
