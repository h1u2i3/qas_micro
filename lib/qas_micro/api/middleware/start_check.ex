defmodule QasMicro.Api.Middleware.StartCheck do
  alias QasCore.Pipeline

  def call(%Pipeline{assigns: %{app: app}} = pipeline) do
    if QasMicro.Cache.start?(app) do
      Pipeline.halt(pipeline)
    else
      pipeline
    end
  end
end
