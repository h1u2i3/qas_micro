defmodule QasMicro.Middleware.Code.Model do
  alias QasMicro.Pipeline
  alias QasMicro.Generator.Model

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    QasMicro.Generator.Model.UUID.render(
      config_module,
      Application.get_env(:qas_micro, :model_keys)
    )

    Enum.map(config_module.parse_object(), &Model.render(config_module, &1))

    pipeline
  end
end
