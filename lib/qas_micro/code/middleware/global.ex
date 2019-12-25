defmodule QasMicro.Code.Middleware.Global do
  alias QasCore.Pipeline
  alias QasMicro.Code.Generator.Global

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Global.render(config_module)

    pipeline
  end
end
