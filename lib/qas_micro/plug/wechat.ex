defmodule QasMicro.Plug.Wechat do
  @behaviour Plug

  import Plug.Conn
  import Wechat.Message

  alias Wechat.Plugs.WechatSignatureResponder, as: Responder
  alias Wechat.Plugs.WechatMessageParser, as: MessageParser

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    %{"application" => application} = conn.params

    application_atom = String.to_atom(application)
    started = QasMicro.Cache.start?(application_atom)

    if !started do
      task = QasMicro.waiting_task(application_atom)
      Task.await(task, :infinity)
    end

    handle_response(application, conn)
  end

  def handle_response(application, conn) do
    wechat_api = Module.safe_concat(["QasApp", Macro.camelize(application), "Wechat"])

    cast_conn =
      conn
      |> Responder.call(Responder.init(api: wechat_api))
      |> MessageParser.call(MessageParser.init(api: wechat_api))

    case cast_conn.method do
      # return with application defined message responder
      "POST" ->
        message = respond_message(cast_conn, application)

        case message do
          "custom_service" ->
            transfer_customer_service(cast_conn)

          _ ->
            send_xml(cast_conn, message)
        end

      _ ->
        signature_responder(cast_conn)
    end
  end

  defp respond_message(conn, app_name) do
    message = conn.assigns[:message]

    # respond_message_params =
    # GenServer.call(QasMicro.Port, {:wechat_message, app_name, Jason.encode!(message)})
    respond_message_params =
      ["QasApp", Macro.camelize(app_name), "Callback"]
      |> Module.safe_concat()
      |> apply(:on_event, ["wechat_message", message])

    case respond_message_params do
      "custom_service" ->
        "custom_service"

      _ ->
        generate_passive(message, respond_message_params)
    end
  end

  defp transfer_customer_service(conn) do
    message = conn.assigns[:message]

    content = """
    <xml>
    <ToUserName><![CDATA[#{Map.get(message, :fromusername)}]]></ToUserName>
    <FromUserName><![CDATA[#{Map.get(message, :tousername)}]]></FromUserName>
    <CreateTime>#{:os.system_time(:second)}</CreateTime>
    <MsgType><![CDATA[transfer_customer_service]]></MsgType>
    </xml>
    """

    send_xml(conn, content)
  end

  defp signature_responder(conn) do
    case conn.assigns[:signature] do
      true -> send_text(conn, conn.params["echostr"])
      false -> send_text(conn, "forbidden")
    end
  end

  defp send_xml(conn, content) do
    conn
    |> put_resp_header("content-type", "application/xml; encoding=utf-8")
    |> send_resp(200, content)
    |> halt
  end

  defp send_text(conn, text) do
    send_resp(conn, 200, text)
  end
end
