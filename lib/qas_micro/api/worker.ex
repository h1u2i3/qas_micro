defmodule QasMicro.Api.Worker do
  alias QasCore.Api.Server
  alias QasMicro.Config.Worker, as: ConfigWorker
  alias QasMicro.Code.Worker, as: CodeWorker
  alias QasMicro.Compiler.Worker, as: CompilerWorker

  alias QasCore.Compiler.Middleware.ModuleClean

  alias QasMicro.Api.Middleware.{
    SetLogger,
    StartCache,
    StopCache,
    StartApi,
    StopApi,
    StartCheck,
    StopCheck
  }

  alias QasMicro.Database.Middleware.{Setup, Up, Migrate}

  require Logger

  # database operation
  def start(arg, success_callback, error_callback, assigns) do
    {app, pre_middlewares, origin_options} = handle_call(arg, assigns)

    Server.run(
      app,
      [StartCheck] ++
        pre_middlewares ++
        CodeWorker.default_middlewares() ++
        CompilerWorker.default_middlewares() ++
        [SetLogger, Setup, Up, StartApi, Migrate, StartCache],
      options(app, success_callback, error_callback, origin_options)
    )
  end

  def stop(app) do
    Server.run(
      app,
      [StopCheck, StopApi, ModuleClean, StopCache],
      options(app, &handle_success/1, &handle_error/2)
    )
  end

  # error and success event handling
  def handle_error(_pipeline, reason), do: Logger.info("error: #{inspect(reason)}")

  def handle_success(_pipeline), do: Logger.info("Api operation success")

  defp handle_call(app, assigns) when is_atom(app), do: handle_call({:app, app}, assigns)

  defp handle_call({:app, app}, assigns) do
    {app, ConfigWorker.default_middlewares(:app), assigns}
  end

  defp handle_call({:string, app, string}, assigns) do
    {app, ConfigWorker.default_middlewares(:string), Map.put(assigns, :config, string)}
  end

  defp handle_call({:file, app, path}, assigns) do
    {app, ConfigWorker.default_middlewares(:file), Map.put(assigns, :path, path)}
  end

  defp handle_call(_, _), do: raise("wrong arguments for code generator")

  defp options(app, success_callback, error_callback, assigns \\ %{}) do
    app
    |> QasMicro.Config.options(assigns)
    |> Map.put(:handle_error, error_callback)
    |> Map.put(:handle_success, success_callback)
  end
end
