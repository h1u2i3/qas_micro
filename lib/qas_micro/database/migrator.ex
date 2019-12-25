defmodule QasMicro.Database.Migrator do
  def migrate(repo, schema_modules, migration_folder) do
    Yacto.XA.transaction([repo], fn ->
      try do
        Code.compiler_options(ignore_module_conflict: true)
        # find all migrations
        migrations =
          :qas
          |> Yacto.Migration.Util.get_migration_files(migration_folder)
          |> Yacto.Migration.Util.load_migrations()

        # add post gis extension
        Ecto.Adapters.SQL.query!(repo, "CREATE EXTENSION IF NOT EXISTS postgis;", [])

        # do migrate
        Yacto.Migration.Migrator.up(:qas, repo, schema_modules, migrations)
      catch
        error ->
          Yacto.XA.rollback(repo, inspect(error))
      after
        Code.compiler_options(ignore_module_conflict: false)
      end
    end)
  end
end
