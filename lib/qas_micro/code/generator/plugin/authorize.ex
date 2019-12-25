defmodule QasMicro.Code.Generator.Plugin.Authorize do
  use QasMicro.Code.Genetator.Template

  alias QasMicro.Util.Map, as: QMap

  @external_resource Path.join(__DIR__, "authorize.eex")

  def render(config_module) do
    auth_object =
      config_module.object()
      |> Enum.filter(&QMap.get(&1, :"plugin.auth"))

    if !Enum.empty?(auth_object) do
      authorize_module_name = config_module.middleware_module("authorize")
      auth_module_names = Enum.map(auth_object, &config_module.model_module(&1.name))

      eex_template_string()
      |> EEx.eval_string(
        config_module: config_module,
        authorize_module_name: authorize_module_name,
        auth_module_names: auth_module_names
      )
      |> config_module.save_file("authorize.ex", "middleware")
    else
      raise("""
      You must add a auth model to do authorize.

      @plugin(~w/auth,password,wechat/a)
      @plugin(:auth)
      """)
    end
  end
end
