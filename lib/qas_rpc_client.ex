defmodule QasMicro do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Pid cache use ets
      QasMicro.Cache,

      # The server of qas_core to do parse
      QasMicro.Api.Server,
      QasMicro.Code.Server,
      QasMicro.Config.Server,
      QasMicro.Compiler.Server,
      QasMicro.Database.Server,

      # The task supervisor
      {Task.Supervisor, name: QasMicro.TaskSupervisor}
    ]

    opts = [strategy: :one_for_one, name: QasMicro.Supervisor, restart: :permanent]

    Supervisor.start_link(children, opts)
  end
end
