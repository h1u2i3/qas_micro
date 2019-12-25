defmodule Mix.Tasks.Db.Up do
  use Mix.Task

  alias QasMicro.Pipeline

  alias QasMicro.Middleware.Config.{ConfigModule, FileConfig, Lexer}
  alias QasMicro.Middleware.Code.{CodeClean, Database}
  alias QasMicro.Middleware.Database.{Setup, Up}

  def run(args) do
    app = Enum.at(args, 0)
    path = Enum.at(args, 1)

    pipeline = %Pipeline{
      assigns: %{
        app: app,
        path: path,
        ebin_folder: "lib",
        save_folder: "lib",
        save_to_file: true,
        database_config: [
          username: "postgres",
          hostname: "localhost",
          extensions: [{Geo.PostGIS.Extension, library: Geo}]
        ]
      }
    }

    Pipeline.chain(pipeline, [CodeClean, FileConfig, Lexer, ConfigModule, Database, Setup, Up])
  end
end
