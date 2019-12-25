defmodule QasMicro.Code.Middleware.Callback do
  alias QasCore.Pipeline
  alias QasMicro.Code.Generator.Callback

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Callback.render(config_module)

    pipeline
  end
end
