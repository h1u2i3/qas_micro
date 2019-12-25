defmodule QasMicro.Code.Generator.Api do
  import QasMicro.Util.Helper, only: [module_atom_from_list: 1]

  def render(config_module) do
    application_name = config_module.name()
    api_module_name = config_module.api_module()
    repo_module_name = config_module.repo_module()
    app_module_name = module_atom_from_list(["QasApp", application_name])

    template()
    |> EEx.eval_string(
      api_module_name: api_module_name,
      repo_module_name: repo_module_name,
      app_module_name: app_module_name
    )
    |> config_module.save_file("api.ex")
  end

  def template do
    """
    defmodule <%= api_module_name %> do
      use Supervisor

      def start_link(init_arg) do
        Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
      end

      @impl true
      def init(_init_arg) do
        children = [
          {<%= repo_module_name %>, []},
          {<%= app_module_name %>, []}
        ]

        Supervisor.init(children, strategy: :one_for_one)
      end
    end
    """
  end
end
