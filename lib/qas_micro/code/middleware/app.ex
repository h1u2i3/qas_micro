defmodule QasMicro.Code.Middleware.App do
  alias QasCore.Pipeline
  alias QasMicro.Code.Generator.App

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    App.render(config_module)

    pipeline
  end
end
