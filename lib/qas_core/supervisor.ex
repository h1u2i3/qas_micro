defmodule QasCore.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      # Pid cache use ets
      QasCore.Cache,

      # The server of qas_core to do parse
      QasCore.Api.Server,
      QasCore.Code.Server,
      QasCore.Config.Server,
      QasCore.Compiler.Server,
      QasCore.Database.Server,

      # The task supervisor
      {Task.Supervisor, name: QasCore.TaskSupervisor}
    ]

    opts = [strategy: :one_for_one, restart: :permanent]

    Supervisor.init(children, opts)
  end
end
