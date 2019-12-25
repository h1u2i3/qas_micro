defmodule QasMicro.Code.Generator.App do
  import QasMicro.Util.Helper, only: [module_atom_from_list: 1]

  def render(config_module) do
    application_name = config_module.name()
    repo_module_name = config_module.repo_module()
    app_module_name = module_atom_from_list(["QasApp", application_name])

    template()
    |> EEx.eval_string(
      app_module_name: app_module_name,
      repo_module_name: repo_module_name,
      application_name: application_name
    )
    |> config_module.save_file("#{application_name}.ex")
  end

  def template do
    """
    defmodule <%= app_module_name %> do
      use GenServer

      alias <%= repo_module_name %>
      alias Ecto.Changeset

      def start_link(default) when is_list(default) do
        GenServer.start_link(__MODULE__, default, name: __MODULE__)
      end

      def get(module_string, id) do
        module_string
        |> module_atom_from_string
        |> Repo.get(id)
      end

      def create(module_string, map) do
        module= module_atom_from_string(module_string)

        module.new()
        |> module.create_changeset(map)
        |> Repo.insert
      end

      def update(module_string, id, map) do
        module_string
        |> module_atom_from_string
        |> Repo.get(id)
        |> Changeset.change(Enum.map(map, fn {k, v} -> { String.to_atom(k), v} end))
        |> Repo.update
      end

      def delete(module_string, id) do
        module_string
        |> module_atom_from_string
        |> Repo.get(id)
        |> Repo.delete
      end

      # Server (callbacks)
      @impl true
      def init(stack) do
        {:ok, stack}
      end

      @impl true
      def handle_call({action, args}, _from, stack) do
        {:reply, apply(__MODULE__, action, args), stack}
      end

      @impl true
      def handle_call(_, _, stack) do
        {:reply, "bad call for <%= app_module_name %>", stack}
      end

      defp module_atom_from_string(module_string) do
        ["QasApp", "<%= application_name %>", "Model", module_string]
        |> Enum.map(&Macro.camelize/1)
        |> Module.concat()
      end
    end
    """
  end
end
