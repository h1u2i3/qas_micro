defmodule QasMicro.Jpush do
  use QasMicro.Parser

  alias QasMicro.Util.Map, as: QMap
  alias QasMicro.Util.Helper

  @sms_url "https://api.sms.jpush.cn/v1/messages"
  @login_token_url "https://api.verification.jpush.cn/v1/web/loginTokenVerify"
  @push_url "https://api.jpush.cn/v3/push"

  def push_notification(app_name, message) do
    with {:ok, response} <- request(app_name, @push_url, message),
         {:ok, result} <- Jason.decode(response.body, keys: :atoms),
         {:ok, msg_id} <- decode_sms_result(result) do
      {:ok, msg_id}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  def send_sms(app_name, data) when is_map(data) do
    # {"mobile":"xxxxxxxxxxx","sign_id":*,"temp_id":*}
    with {:ok, response} <- request(app_name, @sms_url, data),
         {:ok, result} <- Jason.decode(response.body, keys: :atoms),
         {:ok, msg_id} <- decode_sms_result(result) do
      {:ok, msg_id}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  def cellphone(app_name, login_token) when is_atom(app_name) do
    app_name
    |> Atom.to_string()
    |> cellphone(login_token)
  end

  def cellphone(app_name, login_token) do
    # {"id":117270465679982592,"code":8000,"content":"get phone success","exID":"1234566","phone":"HpBLIQ/6SkFl0pAq0LMdw1aZ8RHoofgWmaY//LE+0ahkSdHC5oTCnjrR8Tj8y5naKVI03torFU+EzAQnwtVqAoQyYckT0S3Q02TKuAal3VRGiR5Lmp4g2A5Mh4/W5A4o6QFviHuBVJZE/WV0AzU5w4NGhpyQntOeF0UyovYATy4="
    with {:ok, response} <- request(app_name, @login_token_url, %{loginToken: login_token}),
         {:ok, result} <- Jason.decode(response.body, keys: :atoms),
         {:ok, phone_string} <- fetch_phone_string(result),
         {:ok, cellphone} <- decode_phone_string(app_name, phone_string) do
      {:ok, cellphone}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  def decode_sms_result(result) do
    if msg_id = Map.get(result, :msg_id) do
      {:ok, msg_id}
    else
      {:error, QMap.get(result, :"error.message")}
    end
  end

  defp request(app_name, url, body) do
    config_module = __config_module__(app_name)
    base64_auth_string = Base.encode64(config_module.jpush_verification())

    headers = [
      {:Authorization, "Basic #{base64_auth_string}"},
      {:"Content-Type", "application/json"}
    ]

    HTTPoison.post(url, Jason.encode!(body), headers)
  end

  defp fetch_phone_string(result) do
    case phone_string = Map.get(result, :phone) do
      nil -> {:error, "did not get the cellphone from server"}
      _ -> {:ok, phone_string}
    end
  end

  defp decode_phone_string(app_name, phone_string) do
    module = Helper.module_atom_from_list(["QasApp", app_name])

    jpush_private =
      :qas
      |> Application.get_env(module)
      |> Keyword.get(:jpush_private)
      |> case do
        {:string, private_string} -> private_string
        path when is_binary(path) -> File.read!(path)
      end

    jpush_private_key =
      jpush_private
      |> :public_key.pem_decode()
      |> hd
      |> :public_key.pem_entry_decode()

    case Base.decode64(phone_string) do
      {:ok, list} ->
        cellphone = :public_key.decrypt_private(list, jpush_private_key)

        if cellphone do
          {:ok, cellphone}
        else
          {:error, "bad phone string"}
        end

      {:error, _} ->
        {:error, "bad phone string"}
    end
  end
end
