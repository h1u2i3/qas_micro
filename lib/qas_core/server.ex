defmodule QasCore.Server do
  @moduledoc """
  A Simple process safe server to handle with variety of render steps in the project
  """
  defmacro __using__(_opts) do
    quote do
      use GenServer

      alias QasCore.Pipeline

      require Logger

      # ========
      # Server Code
      # ========
      @impl true
      def init(_) do
        {:ok, %{}}
      end

      # deal with task start, try not to add repeated worker or task
      @impl true
      def handle_cast({:start_task, {app, _pipeline, _middlewares}}, %{app: _ref} = state) do
        {:noreply, state}
      end

      def handle_cast({:start_task, {app, pipeline, middlewares}}, state) do
        task =
          Task.Supervisor.async_nolink(QasCore.TaskSupervisor, fn ->
            pipeline
            |> Map.put(:worker_pid, self())
            |> Pipeline.chain(middlewares)
          end)

        {:noreply, Map.put(state, app, task.ref)}
      end

      # called when the task has successfully return
      @impl true
      def handle_info({ref, pipeline}, state) do
        # demonitor the ref
        Process.demonitor(ref, [:flush])

        # handle success info
        Pipeline.handle_success(pipeline)

        # remove ref relative to the app
        app = find_app(state, ref)
        QasCore.Cache.remove({app, __MODULE__})

        {:noreply, Map.drop(state, [app])}
      end

      # called when the process has error and failed
      @impl true
      def handle_info({:DOWN, ref, :process, _pid, reason}, state) do
        if app = find_app(state, ref) do
          # handle error info
          pipeline = QasCore.Cache.lookup({app, __MODULE__})
          Pipeline.handle_error(pipeline, reason)
          QasCore.Cache.remove({app, __MODULE__})

          {:noreply, Map.drop(state, [app])}
        else
          {:noreply, state}
        end
      end

      def find_app(state, ref) do
        # from app with the specific ref of process
        state
        |> Enum.find({nil}, fn {_key, val} -> val == ref end)
        |> elem(0)
      end

      # ========
      # Client
      # ========
      def start_link(default) when is_list(default) do
        GenServer.start_link(__MODULE__, default, name: __MODULE__)
      end

      def start_task(app, %Pipeline{} = pipeline, middlewares) when is_binary(app) do
        app
        |> String.to_atom()
        |> start_task(pipeline, middlewares)
      end

      def start_task(app, %Pipeline{} = pipeline, middlewares) when is_atom(app) do
        GenServer.cast(__MODULE__, {:start_task, {app, pipeline, middlewares}})
      end

      def start_task(_, _, _), do: Logger.error("Wrong args for start_task/3")
    end
  end
end
