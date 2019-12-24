defmodule QasMicro.Cache do
  @moduledoc """
  Provides storage functionality for job metadata. The metadata is
  associated with the worker pid and automatically discarded when the
  worker process exits.
  """

  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def add({app, level}, value) when is_atom(app) and is_atom(level) do
    GenServer.call(__MODULE__, {:add, {app, level}, value})
  end

  def remove({app, level}) when is_atom(app) and is_atom(level) do
    GenServer.cast(__MODULE__, {:remove, {app, level}})
  end

  def lookup({app, level}) when is_atom(app) and is_atom(level) do
    :ets.lookup_element(__MODULE__, {app, level}, 2)
  end

  ## ===========================================================
  ## gen server callbacks
  ## ===========================================================
  @impl true
  def init(_opts) do
    table = :ets.new(__MODULE__, [:named_table])
    {:ok, table}
  end

  @impl true
  def handle_call({:add, {app, level}, value}, _from, table) do
    true = :ets.insert(table, {{app, level}, value})
    {:reply, :ok, table}
  end

  @impl true
  def handle_cast({:remove, {app, level}}, table) do
    true = :ets.delete(table, {app, level})
    {:noreply, table}
  end
end
