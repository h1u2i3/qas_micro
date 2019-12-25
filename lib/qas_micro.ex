defmodule QasMicro do
  alias QasMicro.Api.Worker, as: ApiWorker
  alias QasMicro.Database.Worker, as: DatabaseWorker

  require Logger

  @doc """
  Start qas api
  """
  def start_api(
        arg,
        success_callback \\ &handle_success/1,
        error_callback \\ &handle_error/2,
        assigns \\ %{}
      ) do
    ApiWorker.start(arg, success_callback, error_callback, assigns)
  end

  @doc """
  Stop qas api
  """
  def stop_api(app) when is_atom(app) do
    ApiWorker.stop(app)
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

  @doc """
  Watting api start task
  """
  def waiting_task(app) do
    Task.async(fn ->
      QasMicro.start_api(app)
      loop(app)
    end)
  end

  def handle_success(_pipeline), do: Logger.info("Start api successful")

  def handle_error(_pipeline, reason),
    do: Logger.info("Start api failed, reason: #{inspect(reason)}")

  defp loop(app) do
    if QasMicro.Cache.start?(app) do
      :ok
    else
      Process.sleep(200)
      loop(app)
    end
  end
end
