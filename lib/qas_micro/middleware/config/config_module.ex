defmodule QasMicro.Middleware.Config.ConfigModule do
  import QasMicro.Util.Helper

  alias QasMicro.Pipeline
  alias QasMicro.Util.Unit

  def call(
        %Pipeline{
          assigns: %{
            app: app,
            config: config,
            save_to_file: save_to_file,
            save_folder: save_folder
          }
        } = pipeline
      ) do
    Code.compiler_options(ignore_module_conflict: true)

    with {{:module, config_module, _, _}, _} <-
           app
           |> render(config, %{save_to_file: save_to_file, save_folder: save_folder})
           |> Code.eval_string() do
      pipeline
      |> Pipeline.remove([:config])
      |> Pipeline.assign(:config_module, config_module)
    else
      _ ->
        raise("error happend when do config module compile")
    end
  after
    Code.compiler_options(ignore_module_conflict: false)
  end

  defp render(app, config, options) do
    config = keyword_to_map(config)

    EEx.eval_string(
      template(),
      config: Unit.new(config),
      keys: config |> Map.keys() |> Unit.new(),
      options: Unit.new(options),
      config_module: module_atom_from_list(["QasApp", "#{app}", "Config"])
    )
  end

  defp template do
    """
    defmodule <%= config_module %> do
      use QasMicro.Config,
        config: <%= config %>,
        keys: <%= keys %>,
        options: <%= options %>
    end
    """
  end
end
