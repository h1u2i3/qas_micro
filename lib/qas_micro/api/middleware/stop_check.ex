defmodule QasMicro.Api.Middleware.StopCheck do
  alias QasCore.Pipeline

  def call(%Pipeline{assigns: %{app: app}} = pipeline) do
    if QasMicro.Cache.start?(app) do
      pipeline
    else
      Pipeline.halt(pipeline)
    end
  end
end
