defmodule QasMicro.Plug.PaymentCallback do
  import Plug.Conn
  import QasMicro.Util.Helper

  def init(opts) do
    opts
  end

  def call(conn, _options) do
    %{"application" => application} = conn.params

    application_atom = String.to_atom(application)
    started = QasMicro.Cache.start?(application_atom)

    if !started do
      task = QasMicro.waiting_task(application_atom)
      Task.await(task, :infinity)
    end

    handle_response(application, conn)
  end

  # wechat
  # %{
  #   appid: "wxc7688e740b5fe070",
  #   bank_type: "CFT",
  #   cash_fee: "2",
  #   fee_type: "CNY",
  #   is_subscribe: "N",
  #   mch_id: "1533445871",
  #   nonce_str: "rZ87GydAbeH2i0W8ExDNJiNdm1g4o",
  #   openid: "otlAR1EFLrB-k7VbSu8OGyH71OwA",
  #   out_trade_no: "662691558689808",
  #   result_code: "SUCCESS",
  #   return_code: "SUCCESS",
  #   sign: "523195344416C96DA4553762DEF20B5C",
  #   time_end: "20190524172409",
  #   total_fee: "2",
  #   trade_type: "APP",
  #   transaction_id: "4200000293201905247900172270"
  # }

  # Alipay
  # %{
  #   app_id: "2019050564330905",
  #   auth_app_id: "2019050564330905",
  #   buyer_id: "2088502998907524",
  #   buyer_logon_id: "sen***@gmail.com",
  #   buyer_pay_amount: "0.01",
  #   charset: "utf-8",
  #   fund_bill_list: "[{\"amount\":\"0.01\",\"fundChannel\":\"PCREDIT\"}]",
  #   gmt_create: "2019-05-29 11:10:53",
  #   gmt_payment: "2019-05-29 11:10:54",
  #   invoice_amount: "0.01",
  #   notify_id: "2019052900222111054007521023998362",
  #   notify_time: "2019-05-29 11:10:54",
  #   notify_type: "trade_status_sync",
  #   out_trade_no: "426931559099289",
  #   point_amount: "0.00",
  #   receipt_amount: "0.01",
  #   seller_email: "tozeal@126.com",
  #   seller_id: "2088531089595951",
  #   sign: "CMF1xAolozenGefJBJP3leny+TnFw83SxD+AAcL+2HYL3nnFE087HvqjQQ+67YBQO58UHuHh8I2SLjPIFdaBxrk7pzTGtPEMUilNUAtr95/gO1xGnaPOkesUpzz+36KLca+2pjO/toYdDPSJ5/v2X0P+NEZMKHBtKGgDVXtK/05q2lyxbQORkjRSiS8EmjvNlC6zPD0STGPSSTDVcSK5gt+1yOtiHt58UKVHG3iRsqQ/9COe0Kdxi3+IVS4OjaKVkuTPEpRiUEDARSNU9y7MR9UGQ+7GI67/wgRmnoJBC4SUKVbjpInkTfwwNtTtcJCP+W6Ck1O3qmai6JLouRUVpg==",
  #   sign_type: "RSA2",
  #   subject: "第1期",
  #   total_amount: "0.01",
  #   trade_no: "2019052922001407521040071901",
  #   trade_status: "TRADE_SUCCESS",
  #   version: "1.0"
  # }

  def handle_response(application, conn) do
    config_module = module_atom_from_list(["QasApp", application, "Config"])
    callback_module = config_module.callback_module()

    wechat_pay_module =
      if Code.ensure_compiled?(config_module.wechat_pay_module()) do
        config_module.wechat_pay_module()
      else
        nil
      end

    alipay_module =
      if Code.ensure_compiled?(config_module.alipay_module()) do
        config_module.alipay_module()
      else
        nil
      end

    {:ok, body, _} = Plug.Conn.read_body(conn)
    body_map = process_response_body(body)

    cast_params =
      conn.params
      |> Map.drop(["application"])
      |> Map.merge(body_map)
      |> Enum.map(fn
        {k, v} when is_binary(k) -> {String.to_atom(k), v}
        item -> item
      end)
      |> Enum.into(%{})
      |> IO.inspect()

    pay_kind =
      if cast_params[:app_id] do
        :alipay
      else
        if cast_params[:appid] do
          :wechat
        else
          :none
        end
      end

    case pay_kind do
      :none ->
        render_error(conn)

      :wechat ->
        # TODO: need to support mutiply app
        if Payment.Wechat.check_signature(wechat_pay_module, cast_params) do
          callback_module.on_event(:payment_callback, Map.put(cast_params, :pay_kind, "wechat"))
          render_success(conn, :wechat)
        else
          render_error(conn)
        end

      :alipay ->
        # TODO: need to support mutiply app
        if Payment.Alipay.check_signature(alipay_module, cast_params) do
          callback_module.on_event(:payment_callback, Map.put(cast_params, :pay_kind, "alipay"))
          render_success(conn, :alipay)
        else
          render_error(conn)
        end
    end
  end

  defp render_success(conn, pay_kind) do
    case pay_kind do
      :alipay ->
        conn
        |> put_resp_header("content-type", "text/html; encoding=utf-8")
        |> send_resp(200, "success")
        |> halt

      :wechat ->
        conn
        |> put_resp_header("content-type", "application/xml; encoding=utf-8")
        |> send_resp(200, success_xml())
        |> halt
    end
  end

  defp render_error(conn) do
    send_resp(conn, 400, "bad request")
  end

  defp success_xml do
    """
    <xml>
    <return_code><![CDATA[SUCCESS]]></return_code>
    <return_msg><![CDATA[OK]]></return_msg>
    </xml>
    """
  end

  defp process_response_body("<xml>" <> _ = body), do: Payment.Tool.Xml.parse_xml(body)
  defp process_response_body("{" <> _ = body), do: Jason.decode!(body)
  defp process_response_body(_), do: %{}
end
