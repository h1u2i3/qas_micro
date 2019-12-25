defmodule QasMicro.Code.Worker do
  alias QasCore.Pipeline
  alias QasCore.Code.Server
  alias QasCore.Code.Middleware.CodeClean

  alias QasMicro.Config.Worker, as: ConfigWorker
  alias QasMicro.Code.Middleware.{Database, Model}

  @middlewares [CodeClean, Database, Model]

  def render(%Pipeline{assigns: %{app: app, config_module: _config_module} = assigns}) do
    Server.render(app, @middlewares, %{assign: assigns})
  end

  def render(%Pipeline{}), do: raise("wrong pipeline for code generator")

  def render({:app, app}) do
    Server.render(app, ConfigWorker.default_middlewares(:app) ++ @middlewares, options(app))
  end

  def render({:string, app, string}) do
    Server.render(
      app,
      ConfigWorker.default_middlewares(:string) ++ @middlewares,
      options(app, %{config: string})
    )
  end

  def render({:file, app, path}) do
    Server.render(
      app,
      ConfigWorker.default_middlewares(:file) ++ @middlewares,
      options(app, %{path: path})
    )
  end

  def render(_), do: raise("wrong arguments for code generator")

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
