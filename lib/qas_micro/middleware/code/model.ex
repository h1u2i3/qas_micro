defmodule QasMicro.Middleware.Code.Model do
  alias QasMicro.Pipeline
  alias QasMicro.Generator.Model

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Enum.map(config_module.parse_object(), &Model.render(config_module, &1))

    pipeline
  end
end
