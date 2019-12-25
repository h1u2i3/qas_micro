defmodule QasMicro.Code.Generator.Config do
  import QasMicro.Util.Helper,
    only: [keyword_to_map: 1, module_atom_from_list: 1, get_value_or_raise: 2]

  alias QasMicro.Util.Unit

  def render(origin_config, options) do
    config = keyword_to_map(origin_config)
    application_name = get_value_or_raise(config, :name)

    EEx.eval_string(template(),
      config: Unit.new(config),
      keys: config |> Map.keys() |> Unit.new(),
      options: Unit.new(options),
      config_module_atom: module_atom_from_list(["QasApp", application_name, "Config"])
    )
  end

  def template do
    """
    defmodule <%= config_module_atom %> do
      use QasMicro.Config,
        config: <%= config %>,
        keys: <%= keys %>,
        options: <%= options %>
    end
    """
  end
end
