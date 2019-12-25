defmodule QasCore.Pipeline do
  @moduledoc """
  github: https://github.com/akira/exq
  Copy from lib/exq/middleware/pipeline.ex
  """
  alias QasCore.Pipeline

  require Logger

  defstruct name: nil,
            assigns: %{},
            halted: false,
            terminated: false,
            worker_pid: nil,
            event: nil,
            handle_error: nil,
            handle_success: nil

  @doc """
  Success event handling for pipeline
  """
  def handle_success(%Pipeline{handle_success: handle_success} = pipeline) do
    if is_function(handle_success) do
      handle_success.(pipeline)
    else
      Logger.info("#{pipeline.name} task completed!")
    end
  end

  @doc """
  Error event handling for pipeline
  """
  def handle_error(%Pipeline{handle_error: handle_error} = pipeline, reason) do
    if is_function(handle_error) do
      handle_error.(pipeline, reason)
    else
      Logger.info("#{pipeline.name} task failed, the reason is #{reason}!")
    end
  end

  @doc """
  Puts the `key` with value equal to `value` into `assigns` map
  """
  def assign(%Pipeline{assigns: assigns} = pipeline, key, value) when is_atom(key) do
    %{pipeline | assigns: Map.put(assigns, key, value)}
  end

  @doc """
  Remove the value and key from assigns
  """
  def remove(%Pipeline{} = pipeline, key) when is_atom(key) do
    remove(pipeline, [key])
  end

  def remove(%Pipeline{assigns: assigns} = pipeline, keys) when is_list(keys) do
    %{pipeline | assigns: Map.drop(assigns, keys)}
  end

  @doc """
  Sets `halted` to true
  """
  def halt(%Pipeline{} = pipeline) do
    %{pipeline | halted: true}
  end

  @doc """
  Sets `terminated` to true
  """
  def terminate(%Pipeline{} = pipeline) do
    %{pipeline | terminated: true}
  end

  @doc """
  Implements middleware chain: sequential call of function with `pipeline.event` name inside `module` module
  """
  def chain(pipeline, []) do
    pipeline
  end

  def chain(%Pipeline{halted: true} = pipeline, _modules) do
    pipeline
  end

  def chain(%Pipeline{terminated: true} = pipeline, _modules) do
    pipeline
  end

  def chain(pipeline, [module | modules]) do
    cast_pipeline = apply(module, pipeline.event, [pipeline])

    level = Map.get(pipeline.assigns, :module)
    app = Map.get(pipeline.assigns, :app)

    if level && app do
      QasCore.Cache.add({app, level}, cast_pipeline)
    end

    chain(cast_pipeline, modules)
  end
end
