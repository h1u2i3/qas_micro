defmodule QasMicro.Code.Generator.Database do
  def render_repo(config_module) do
    QasMicro.Code.Generator.Database.Repo.render(config_module)
  end

  def render_schema(config_module) do
    Enum.each(
      config_module.object(),
      &QasMicro.Code.Generator.Database.Schema.render(config_module, &1)
    )
  end
end
