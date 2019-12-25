defmodule QasMicro.Database.GenMigration do
  @moduledoc """
  User Yacto migration toll to gen migrations
  """
  def run(schema_modules, migration_folder) do
    Code.compiler_options(ignore_module_conflict: true)

    Yacto.Migration.GenMigration.generate_migration(
      :qas,
      schema_modules,
      [],
      nil,
      migration_folder,
      Application.get_env(:yacto, :migration, [])
    )
  after
    Code.compiler_options(ignore_module_conflict: false)
  end
end
