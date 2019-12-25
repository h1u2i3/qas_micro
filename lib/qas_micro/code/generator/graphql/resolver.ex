defmodule QasMicro.Code.Generator.Graphql.Resolver do
  use QasMicro.Code.Genetator.Template
  @external_resource Path.join(__DIR__, "resolver.eex")

  def render(config_module) do
    resolver_module_name = config_module.resolver_module()
    repo_module_name = config_module.repo_module()
    schema_module_name = config_module.schema_module()
    abilities_module_name = config_module.abilities_module()
    wechat_api_module_name = config_module.wechat_module()
    global_module_name = config_module.global_module()

    wechat_pay_module = config_module.wechat_pay_module()
    alipay_module = config_module.alipay_module()
    qiniu_module = config_module.qiniu_module()

    eex_template_string()
    |> EEx.eval_string(
      application_name: config_module.name(),
      resolver_module_name: resolver_module_name,
      repo_module_name: repo_module_name,
      schema_module_name: schema_module_name,
      abilities_module_name: abilities_module_name,
      wechat_api_module_name: wechat_api_module_name,
      wechat_pay_module: wechat_pay_module,
      alipay_module: alipay_module,
      qiniu_module: qiniu_module,
      global_module_name: global_module_name
    )
    |> config_module.save_file("resolver.ex")
  end
end
