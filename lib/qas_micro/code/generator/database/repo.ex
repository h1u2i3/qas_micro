defmodule QasMicro.Code.Generator.Database.Repo do
  def render(config_module) do
    repo_module = config_module.repo_module()

    repo_template()
    |> EEx.eval_string(repo_module: repo_module)
    |> config_module.save_file("repo.ex")
  end

  defp repo_template do
    """
    defmodule <%= repo_module %> do
      use Ecto.Repo, otp_app: :qas, adapter: Ecto.Adapters.Postgres
    end
    """
  end
end
