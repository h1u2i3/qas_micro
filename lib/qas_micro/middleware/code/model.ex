defmodule QasMicro.Middleware.Code.Model do
  alias QasMicro.Pipeline
  alias QasMicro.Generator.Model

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    config_module.parse_object()
    |> Enum.filter(fn item -> Map.get(item, :polymorphic, false) end)
    |> Enum.map(&Model.render(config_module, &1))

    pipeline
  end
end
