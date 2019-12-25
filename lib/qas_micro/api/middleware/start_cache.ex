defmodule QasMicro.Api.Middleware.StartCache do
  alias QasCore.Pipeline

  def call(%Pipeline{assigns: %{app: app}} = pipeline) do
    QasMicro.Cache.start!(app)

    pipeline
  end
end
