defmodule QasMicro.Cache do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def init_cache(application, modules) do
    Agent.update(__MODULE__, fn value ->
      value
      |> Map.get_and_update(application, fn
        old when is_map(old) ->
          {old,
           old
           |> Map.put(:modules, modules)
           |> Map.put(:status, :stop)}

        old ->
          {old, %{modules: modules, status: :stop}}
      end)
      |> elem(1)
    end)
  end

  def get_cache(application) do
    Agent.get(__MODULE__, fn value ->
      Map.get(value, application)
    end)
  end

  def set_log_pid(application, pid) do
    Agent.update(__MODULE__, fn value ->
      value
      |> Map.get_and_update(application, fn
        old when is_map(old) -> {old, Map.put(old, :log_pid, pid)}
        old -> {old, %{log_pid: pid}}
      end)
      |> elem(1)
    end)
  end

  def start?(application) do
    result =
      Agent.get(__MODULE__, fn value ->
        Map.get(value, application)
      end) || %{}

    Map.get(result, :status, :stop) == :start
  end

  def starting?(application) do
    result =
      Agent.get(__MODULE__, fn value ->
        Map.get(value, application)
      end) || %{}

    Map.get(result, :status, :stop) == :starting
  end

  def start!(application) do
    Agent.update(__MODULE__, fn value ->
      value
      |> Map.get_and_update(application, fn old ->
        {old, %{old | status: :start}}
      end)
      |> elem(1)
    end)
  end

  def starting!(application) do
    Agent.update(__MODULE__, fn value ->
      value
      |> Map.get_and_update(application, fn old ->
        {old, %{status: :starting}}
      end)
      |> elem(1)
    end)
  end

  def stop!(application) do
    Agent.update(__MODULE__, fn value ->
      value
      |> Map.get_and_update(application, fn old ->
        {old, %{old | status: :stop}}
      end)
      |> elem(1)
    end)
  end

  def schema_modules(application) do
    Agent.get(__MODULE__, fn value ->
      app_cache = Map.get(value, application, %{})
      modules = Map.get(app_cache, :modules, [])
      Enum.filter(modules, &(&1 |> Atom.to_string() |> String.contains?("Migration")))
    end)
  end
end
