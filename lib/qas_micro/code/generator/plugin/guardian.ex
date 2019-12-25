defmodule QasMicro.Code.Generator.Plugin.Guardian do
  use QasMicro.Code.Genetator.Template

  alias QasMicro.Util.Map, as: QMap

  @external_resource Path.join(__DIR__, "guardian.eex")

  def render(config_module) do
    application_name = config_module.name()
    guardian_module_name = config_module.guardian_module()
    repo_module_name = config_module.repo_module()

    auth_object =
      config_module.object()
      |> Enum.filter(&QMap.get(&1, :"plugin.auth"))

    if !Enum.empty?(auth_object) do
      Application.put_env(:qas, guardian_module_name,
        issuer: "qas_#{application_name}",
        secret_key: config_module.guardian_key(),
        ttl: Application.get_env(:qas, :guardian_ttl, {4, :weeks})
      )

      resource_names = Enum.map(auth_object, &config_module.model_module(&1.name))

      eex_template_string()
      |> EEx.eval_string(
        guardian_module_name: guardian_module_name,
        repo_module_name: repo_module_name,
        resource_names: resource_names
      )
      |> config_module.save_file("guardian.ex")
    else
      raise("""
      You must add a auth model to do guardian.

      @plugin(~w/auth,password,wechat/a)
      @plugin(:auth)
      """)
    end
  end
end
