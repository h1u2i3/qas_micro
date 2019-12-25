defmodule QasMicro.Database.Middleware.Migrate do
  alias QasCore.Pipeline
  alias QasMicro.Database.{GenMigration, Migrator}

  def call(
        %Pipeline{
          assigns: %{app: app, config_module: config_module, migration_app: migration_app}
        } = pipeline
      ) do
    repo = config_module.repo_module()
    app_name = config_module.name()

    try do
      Code.compiler_options(ignore_module_conflict: true)

      migration_folder =
        if migration_app do
          migration_app
          |> :code.priv_dir()
          |> List.to_string()
          |> Path.join("migrations")
        else
          "priv/migrations"
        end
        |> Path.join(app_name)

      schema_modules = QasMicro.Cache.schema_modules(app)

      # TODO: better error handle
      # try do
      repo.start_link()
      GenMigration.run(schema_modules, migration_folder)
      Migrator.migrate(repo, schema_modules, migration_folder)
      :ok
    after
      repo.stop()
      Code.compiler_options(ignore_module_conflict: false)
    end

    pipeline
  end
end
