defmodule QasMicro.Code.Middleware.Wechat do
  alias QasCore.Pipeline
  alias QasMicro.Code.Generator.Wechat

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Wechat.render(config_module)

    pipeline
  end
end
