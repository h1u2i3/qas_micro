defmodule QasCore.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

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

    opts = [strategy: :one_for_one, name: QasCore.Supervisor, restart: :permanent]

    Supervisor.start_link(children, opts)
  end
end
