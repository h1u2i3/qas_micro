defmodule QasMicro.Code.Generator.Wechat do
  def render(config_module) do
    wechat_config =
      if(Enum.any?(config_module.__info__(:functions), &(elem(&1, 0) == :wechat))) do
        config_module.wechat()
      else
        %{}
      end

    case wechat_config do
      %{appid: appid, appsecret: appsecret, token: token} ->
        wechat_module_name = config_module.wechat_module()

        template()
        |> EEx.eval_string(
          appid: appid,
          appsecret: appsecret,
          token: token,
          wechat_module_name: wechat_module_name
        )
        |> config_module.save_file("wechat.ex")

      _ ->
        # IO.inspect("didn't get usable wechat config, skip....")
        nil
    end
  end

  defp template do
    """
    defmodule <%= wechat_module_name %> do
      use Wechat.Api,
        appid: "<%= appid %>",
        secret: "<%= appsecret %>",
        token: "<%= token %>"
    end
    """
  end
end
