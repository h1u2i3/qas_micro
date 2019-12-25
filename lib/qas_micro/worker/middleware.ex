defmodule QasMicro.Worker.Middleware do
  @behaviour Exq.Middleware.Behaviour

  alias QasMicro.Worker.PurposeLogger
  import Exq.Middleware.Pipeline

  def before_work(pipeline) do
    app_name = app_name_from_module(pipeline.assigns.worker_module)
    backend = add_logger_backend(app_name, pipeline.assigns.job)

    pipeline
    |> assign(:app_name, app_name)
    |> assign(:qas_logger, backend)
  end

  def after_processed_work(pipeline) do
    pipeline
  end

  def after_failed_work(pipeline) do
    pipeline
  end

  defp app_name_from_module(module) do
    module
    |> Module.split()
    |> Enum.at(1)
    |> Macro.underscore()
  end

  defp add_logger_backend(app_name, job) do
    %{jid: jid} = job

    config_fetcher = QasMicro.Config.config()[:config_fetcher]
    backend = {PurposeLogger, "app_#{app_name}_#{jid}"}
    keyword = Keyword.put([], String.to_atom("app_#{app_name}"), jid)

    Logger.add_backend(backend)

    Logger.configure_backend(
      backend,
      level: :debug,
      handler: &config_fetcher.handle_worker_log(app_name, job, &1),
      metadata_filter: keyword
    )

    Logger.metadata(keyword)
    backend
  end
end
