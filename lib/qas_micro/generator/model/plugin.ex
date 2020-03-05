defmodule QasMicro.Generator.Model.Plugin do
  use QasMicroGenetator.Template

  @external_resource Path.join(__DIR__, "plugin.eex")

  def render(
        config_module,
        object_name,
        model_module,
        model_plugin_module
      ) do
    eex_template_string()
    |> EEx.eval_string(
      model_module: model_module,
      model_plugin_module: model_plugin_module
    )
    |> config_module.save_file("#{object_name}.ex", "model")
  end
end
