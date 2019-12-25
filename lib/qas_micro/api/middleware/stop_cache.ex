defmodule QasMicro.Api.Middleware.StopCache do
  alias QasCore.Pipeline

  def call(%Pipeline{assigns: %{app: app}} = pipeline) do
    QasMicro.Cache.stop!(app)

    pipeline
  end
end
