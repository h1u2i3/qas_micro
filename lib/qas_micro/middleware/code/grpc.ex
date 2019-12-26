defmodule QasMicro.Middleware.Code.Grpc do
  alias QasMicro.Pipeline
  alias QasMicro.Generator.Grpc

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    Grpc.render_server(config_module)
    Grpc.render_endpoint(config_module)

    pipeline
  end
end
