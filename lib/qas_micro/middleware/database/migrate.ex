defmodule QasMicro.Middleware.Database.Migrate do
  alias QasMicro.Pipeline
  alias QasMicro.Database.{GenMigration, Migrator}

  def call(
        %Pipeline{
          assigns: %{app: app, config_module: config_module}
        } = pipeline
      ) do
    repo = config_module.repo_module()
    app_name = config_module.name()

    try do
      Code.compiler_options(ignore_module_conflict: true)

      migration_folder = "priv/migrations"
      schemas = Yacto.Migration.Util.get_all_schema(:qas_micro) || []

      # TODO: better error handle
      # try do
      repo.start_link()
      GenMigration.run(schemas, migration_folder)
      Migrator.migrate(repo, schemas, migration_folder)
      :ok
    after
      # repo.stop()
      Code.compiler_options(ignore_module_conflict: false)
    end

    pipeline
  end
end
