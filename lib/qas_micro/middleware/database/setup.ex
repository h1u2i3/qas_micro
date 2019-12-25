defmodule QasMicro.Middleware.Database.Setup do
  alias QasMicro.Pipeline

  import QasMicro.Util.Helper

  def call(
        %Pipeline{assigns: %{config_module: config_module, database_config: database_config}} =
          pipeline
      ) do
    ensure_database_config(config_module, database_config)
    pipeline
  end

  defp ensure_database_config(config_module, database_config) do
    repo = config_module.repo_module()
    database_name = config_module.env_database_name()

    get_and_update_env(:qas, repo, fn old ->
      old ||
        database_config
        |> Keyword.put(:database, database_name)
        |> Keyword.put(:types, QasMicro.PostgresTypes)
    end)

    get_and_update_env(:yacto, :databases, fn old ->
      old
      |> Kernel.||(%{})
      |> Map.put(String.to_atom(database_name), %{module: Yacto.DB.Single, repo: repo})
    end)
  end
end
