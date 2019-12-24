defmodule QasMicro.Config.Middleware.StringConfig do
  alias QasMicro.Pipeline

  def call(%Pipeline{assigns: %{config: config}} = pipeline) when is_binary(config) do
    pipeline
  end

  def call(_), do: raise("you must provide the right config string")
end
