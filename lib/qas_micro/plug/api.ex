defmodule QasMicro.Plug.Api do
  import Plug.Conn
  require Logger

  @behaviour Plug

  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    # setup the application module service
    # load_context
    %{"application" => application} = conn.params

    setting_loging(application)
    Logger.metadata(app: application)

    application_atom = String.to_atom(application)
    started = QasMicro.Cache.start?(application_atom)

    if !started do
      task = QasMicro.waiting_task(application_atom)
      Task.await(task, :infinity)
    end

    handle_response(application, conn)
  end

  def handle_response(application, conn) do
    schema_module = Module.concat(["QasApp", Macro.camelize(application), "Schema"])
    module = Module.concat(["QasApp", Macro.camelize(application), "Context"])

    if :code.is_loaded(schema_module) do
      cast_conn = module.call(conn, module.init([]))

      # graphql
      if String.contains?(cast_conn.request_path, "graphiql") do
        Absinthe.Plug.GraphiQL.call(
          cast_conn,
          Absinthe.Plug.GraphiQL.init(
            schema: schema_module,
            interface: :advanced,
            default_url: schema_module.default_url,
            scope: "__absinthe__:#{application}:control"
          )
        )
      else
        Absinthe.Plug.call(
          cast_conn,
          Absinthe.Plug.init(
            schema: schema_module,
            json_codec: Jason
          )
        )
      end
    else
      handle_unsupport(conn)
    end
  end

  defp handle_unsupport(conn) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(404, "not_found")
    |> halt
  end

  defp setting_loging(application) do
    backend = {LoggerFileBackend, String.to_atom("app_#{application}")}
    Logger.add_backend(backend)

    Logger.configure_backend(
      backend,
      level: :debug,
      path: app_log_path(application),
      metadata_filter: [app: application]
    )
  end

  defp app_log_path(app_name) do
    :qas
    |> Application.get_env(:ebin_folder, "ebin")
    |> Path.join("log/#{app_name}.log")
  end
end
