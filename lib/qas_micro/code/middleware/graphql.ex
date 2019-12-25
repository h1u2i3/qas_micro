defmodule QasMicro.Code.Middleware.Graphql do
  alias QasCore.Pipeline
  alias QasMicro.Code.Generator.Graphql

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Graphql.render_type(config_module)
    Graphql.render_resolver(config_module)
    Graphql.render_schema(config_module)

    pipeline
  end
end
