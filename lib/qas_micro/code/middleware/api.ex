defmodule QasMicro.Code.Middleware.Api do
  alias QasCore.Pipeline
  alias QasMicro.Code.Generator.Api

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Api.render(config_module)

    pipeline
  end
end
