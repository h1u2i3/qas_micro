defmodule QasMicro.Code.Generator.Plugin.Payment do
  use QasMicro.Code.Genetator.Template

  import QasMicro.Util.Helper, only: [map_to_keyword: 1, module_atom_from_list: 1]

  def render(config_module) do
    setting = config_module.setting()
    wechat_pay_module_name = config_module.wechat_pay_module()
    alipay_module_name = config_module.alipay_module()

    app_module = module_atom_from_list(["QasApp", config_module.name()])
    app_module_setting = Application.get_env(:qas, app_module, [])

    wechat_pay_config =
      Map.get(setting, :wechat_pay) &&
        setting
        |> Map.get(:wechat_pay)
        |> Map.put_new(:cert, Keyword.get(app_module_setting, :wechat_pay_public))
        |> Map.put_new(:cert_key, Keyword.get(app_module_setting, :wechat_pay_private))

    alipay_config =
      Map.get(setting, :alipay) &&
        setting
        |> Map.get(:alipay)
        # 支付宝的商户 Public key, 而非 应用的 Public key
        |> Map.put_new(:public_key, Keyword.get(app_module_setting, :alipay_public))
        |> Map.put_new(:alipay_private, Keyword.get(app_module_setting, :alipay_private))

    wechat_pay_code =
      wechat_pay_config &&
        """
        defmodule #{wechat_pay_module_name} do
          use Payment.Custom, #{Macro.to_string(map_to_keyword(wechat_pay_config))}
        end
        """

    alipay_code =
      alipay_config &&
        """
        defmodule #{alipay_module_name} do
          use Payment.Custom, #{Macro.to_string(map_to_keyword(alipay_config))}
        end
        """

    """
    #{wechat_pay_code}
    #{alipay_code}
    """
    |> config_module.save_file("payment.ex")
  end
end
