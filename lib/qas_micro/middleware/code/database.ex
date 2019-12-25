defmodule QasMicro.Middleware.Code.Database do
  alias QasMicro.Pipeline
  alias QasMicro.Generator.Database

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Database.render_repo(config_module)
    Database.render_schema(config_module)

    pipeline
  end
end
