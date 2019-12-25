defmodule QasMicro.Compiler.Worker do
  alias QasCore.Pipeline
  alias QasCore.Compiler.Server
  alias QasCore.Compiler.Middleware.ModuleClean
  alias QasMicro.Compiler.Middleware.Compiler

  alias QasMicro.Config.Worker, as: ConfigWorker
  alias QasMicro.Code.Worker, as: CodeWorker

  @middlewares [
    ModuleClean,
    Compiler
  ]

  # when only supply app name
  # we should use the customconfig to parse the config
  def compile(%Pipeline{assigns: %{app: app, config_module: _config_module} = assigns}) do
    Server.compile(app, @middlewares, %{assign: assigns})
  end

  def compile(%Pipeline{}), do: raise("wrong pipeline for code generator")

  def compile({:app, app}) do
    Server.compile(
      app,
      ConfigWorker.default_middlewares(:app) ++ CodeWorker.default_middlewares() ++ @middlewares,
      options(app)
    )
  end

  def compile({:string, app, string}) do
    Server.compile(
      app,
      ConfigWorker.default_middlewares(:string) ++
        CodeWorker.default_middlewares() ++ @middlewares,
      options(app, %{config: string})
    )
  end

  def compile({:file, app, path}) do
    Server.compile(
      app,
      ConfigWorker.default_middlewares(:file) ++ CodeWorker.default_middlewares() ++ @middlewares,
      options(app, %{path: path})
    )
  end

  def compile(_), do: raise("wrong arguments for code generator")

  def handle_error(_pipeline, reason), do: IO.inspect("error: #{inspect(reason)}")

  def handle_success(_pipeline), do: IO.inspect("success")

  def default_middlewares, do: @middlewares

  defp options(app, assigns \\ %{}) do
    app
    |> QasMicro.Config.options(assigns)
    |> Map.put(:handle_error, &handle_error/2)
    |> Map.put(:handle_success, &handle_success/1)
  end
end
