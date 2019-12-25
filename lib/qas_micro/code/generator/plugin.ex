defmodule QasMicro.Code.Generator.Plugin do
  def render_guardian(config_module) do
    QasMicro.Code.Generator.Plugin.Guardian.render(config_module)
  end

  def render_context(config_module) do
    QasMicro.Code.Generator.Plugin.Context.render(config_module)
  end

  def render_abilities(config_module) do
    QasMicro.Code.Generator.Plugin.Abilities.render(config_module)
  end

  def render_authorize(config_module) do
    QasMicro.Code.Generator.Plugin.Authorize.render(config_module)
  end

  def render_worker(config_module) do
    QasMicro.Code.Generator.Plugin.Worker.render(config_module)
  end

  def render_payment(config_module) do
    QasMicro.Code.Generator.Plugin.Payment.render(config_module)
  end

  def render_qiniu(config_module) do
    QasMicro.Code.Generator.Plugin.Qiniu.render(config_module)
  end

  def render_socket(config_module) do
    QasMicro.Code.Generator.Plugin.Socket.render(config_module)
  end
end
