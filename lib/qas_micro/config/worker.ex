defmodule QasMicro.Config.Worker do
  alias QasCore.Config.Server
  alias QasCore.Config.Middleware.{StringConfig, CustomConfig, FileConfig, Lexer}
  alias QasMicro.Config.Middleware.ConfigModule

  # when only supply app name
  # we should use the customconfig to parse the config
  def parse({:app, app}) do
    Server.parse(app, [CustomConfig, Lexer, ConfigModule], options(app))
  end

  def parse({:string, app, string}) do
    Server.parse(app, [StringConfig, Lexer, ConfigModule], options(app, %{config: string}))
  end

  def parse({:file, app, path}) do
    Server.parse(app, [FileConfig, Lexer, ConfigModule], options(app, %{path: path}))
  end

  def parse(_), do: raise("wrong arguments for config generator")

  def handle_error(_pipeline, reason), do: IO.inspect("error: #{inspect(reason)}")

  def handle_success(_pipeline), do: IO.inspect("success")

  def default_middlewares(:app), do: [CustomConfig, Lexer, ConfigModule]

  def default_middlewares(:string), do: [StringConfig, Lexer, ConfigModule]

  def default_middlewares(:file), do: [FileConfig, Lexer, ConfigModule]

  defp options(app, assigns \\ %{}) do
    app
    |> QasMicro.Config.options(assigns)
    |> Map.put(:handle_error, &handle_error/2)
    |> Map.put(:handle_success, &handle_success/1)
  end
end
