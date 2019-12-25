defmodule QasMicro.Code.Generator.Plugin.Qiniu do
  use QasMicro.Code.Genetator.Template

  import QasMicro.Util.Helper, only: [map_to_keyword: 1]

  def render(config_module) do
    setting = config_module.setting()
    qiniu_config = Map.get(setting, :qiniu)
    qiniu_module_name = config_module.qiniu_module()

    qiniu_code =
      qiniu_config &&
        """
        defmodule #{qiniu_module_name} do
          use Qiniu.Config, #{Macro.to_string(map_to_keyword(qiniu_config))}
        end
        """

    config_module.save_file(qiniu_code, "qiniu.ex")
  end
end
