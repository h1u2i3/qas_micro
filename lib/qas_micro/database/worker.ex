defmodule QasMicro.Database.Worker do
  alias QasCore.Database.Server
  alias QasMicro.Config.Worker, as: ConfigWorker
  alias QasMicro.Database.Middleware.{Setup, Up, Migrate, Seed, Down}

  require Logger

  # database operation
  def up(arg) do
    {app, pre_middlewares, options} = handle_call(arg, :setup)
    Server.run(app, pre_middlewares ++ [Setup, Up], options)
  end

  def migrate(arg) do
    {app, pre_middlewares, options} = handle_call(arg, :migrate)
    Server.run(app, pre_middlewares ++ [Setup, Up, Migrate], options)
  end

  def seed(arg) do
    {app, pre_middlewares, options} = handle_call(arg, :seed)
    Server.run(app, pre_middlewares ++ [Setup, Up, Seed], options)
  end

  def down(arg) do
    {app, pre_middlewares, options} = handle_call(arg, :down)
    Server.run(app, pre_middlewares ++ [Setup, Down], options)
  end

  # error and success event handling
  def handle_error(_pipeline, reason), do: Logger.info("error: #{inspect(reason)}")

  def handle_success(_pipeline), do: Logger.info("Database operation success")

  # handle call with different args
  defp handle_call({:app, app}, action) do
    {app, ConfigWorker.default_middlewares(:app), options(app, action)}
  end

  defp handle_call({:string, app, string}, action) do
    {app, ConfigWorker.default_middlewares(:string), options(app, action, %{config: string})}
  end

  defp handle_call({:file, app, path}, action) do
    {app, ConfigWorker.default_middlewares(:file), options(app, action, %{path: path})}
  end

  defp handle_call(_, _), do: raise("wrong arguments for code generator")

  defp options(app, action, assigns \\ %{}) do
    app
    |> QasMicro.Config.options(assigns)
    |> Map.put(:name, action)
    |> Map.put(:handle_error, &handle_error/2)
    |> Map.put(:handle_success, &handle_success/1)
  end
end
