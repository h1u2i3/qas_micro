defmodule QasMicro.Code.Generator.Plugin.Context do
  use QasMicro.Code.Genetator.Template
  @external_resource Path.join(__DIR__, "context.eex")

  def render(config_module) do
    app_name = config_module.name()
    global_module_name = config_module.global_module()
    callback_module_name = config_module.callback_module()
    guardian_module_name = config_module.guardian_module()
    context_module_name = config_module.context_module()

    eex_template_string()
    |> EEx.eval_string(
      app_name: app_name,
      guardian_module_name: guardian_module_name,
      context_module_name: context_module_name,
      global_module_name: global_module_name,
      callback_module_name: callback_module_name
    )
    |> config_module.save_file("context.ex")
  end
end
