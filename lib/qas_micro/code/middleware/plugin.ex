defmodule QasMicro.Code.Middleware.Plugin do
  alias QasCore.Pipeline
  alias QasMicro.Code.Generator.Plugin

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Plugin.render_guardian(config_module)
    Plugin.render_context(config_module)
    Plugin.render_abilities(config_module)
    Plugin.render_authorize(config_module)
    Plugin.render_worker(config_module)
    Plugin.render_payment(config_module)
    Plugin.render_qiniu(config_module)
    Plugin.render_socket(config_module)

    pipeline
  end
end
