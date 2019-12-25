defmodule QasMicro.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      QasCore.Application
    ]

    opts = [strategy: :one_for_one, name: QasMicro.Supervisor, restart: :permanent]

    Supervisor.start_link(children, opts)
  end
end
