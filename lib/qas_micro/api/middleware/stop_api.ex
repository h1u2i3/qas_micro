defmodule QasMicro.Api.Middleware.StopApi do
  alias QasCore.Pipeline
  alias QasMicro.Util.Helper

  def call(%Pipeline{assigns: %{app: app}} = pipeline) do
    api_module = Helper.module_atom_from_list(["QasApp", "#{app}", "Api"])
    Supervisor.terminate_child(QasMicro.Supervisor, api_module)
    Supervisor.delete_child(QasMicro.Supervisor, api_module)

    pipeline
  end
end
