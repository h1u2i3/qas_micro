defmodule QasMicro.Database.Middleware.Down do
  alias QasCore.Pipeline

  def call(%Pipeline{assigns: %{app: app, config_module: config_module}} = pipeline) do
    Code.compiler_options(ignore_module_conflict: true)

    config_module
    |> QasMicro.Code.Generator.Database.Repo.render()
    |> Code.eval_string()

    repo = config_module.repo_module()
    repo.__adapter__.storage_down(repo.config)

    pipeline
  after
    Code.compiler_options(ignore_module_conflict: false)
  end
end
