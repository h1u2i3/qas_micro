defmodule QasMicro.Code.Middleware.Database do
  alias QasCore.Pipeline
  alias QasMicro.Code.Generator.Database

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Database.render_repo(config_module)
    Database.render_schema(config_module)

    pipeline
  end
end
