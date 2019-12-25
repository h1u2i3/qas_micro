defmodule QasMicro.Api.Middleware.SetLogger do
  alias QasCore.Pipeline

  require Logger

  def call(
        %Pipeline{
          assigns: %{
            app: app,
            ebin_folder: ebin_folder,
            config_fetcher: config_fetcher
          }
        } = pipeline
      ) do
    if config_fetcher do
      set_logging(app, config_fetcher, ebin_folder)
      Logger.metadata(app: Atom.to_string(app))
    end

    pipeline
  end

  defp set_logging(app, config_fetcher, ebin_folder) do
    backend = {LoggerFileBackend, String.to_atom("app_#{app}")}
    Logger.add_backend(backend)

    Logger.configure_backend(
      backend,
      level: :debug,
      path: "#{ebin_folder}/log/#{app}.log",
      metadata_filter: [app: Atom.to_string(app)]
    )

    {:ok, pid} =
      QasMicro.Tail.start_link(
        "#{ebin_folder}/log/#{app}.log",
        &config_fetcher.handle_sync_log(app, &1)
      )

    QasMicro.Cache.set_log_pid(app, pid)
  end
end
