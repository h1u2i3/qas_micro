defmodule QasCore.Config.Server do
  @moduledoc """
  Server to generate project code
  """
  use QasCore.Server

  alias QasCore.Pipeline

  require Logger

  # middlewares:
  def parse(app, middlewares, options) do
    pipeline = %Pipeline{
      event: :call,
      assigns:
        options
        |> Map.get(:assigns, %{})
        |> Map.put(:app, app)
        |> Map.put(:module, __MODULE__),
      handle_error: Map.get(options, :handle_error, &handle_error/2),
      handle_success: Map.get(options, :handle_success, &handle_success/1)
    }

    start_task(app, pipeline, middlewares)
  end

  def handle_success(_pipeline) do
    Logger.info("Config parse success")
  end

  def handle_error(_pipeline, reason) do
    Logger.error("Config parse failed, reason: #{inspect(reason)}")
  end
end
