defmodule QasMicro.Middleware.Config.CustomConfig do
  alias QasMicro.Pipeline

  def call(%Pipeline{assigns: %{config_fetcher: config_fetcher, app: app}} = pipeline)
      when is_atom(config_fetcher) do
    config = config_fetcher.config(app)
    Pipeline.assign(pipeline, :config, config)
  end

  def call(_), do: raise("you must provide the right config_fetcher module and app name")
end
