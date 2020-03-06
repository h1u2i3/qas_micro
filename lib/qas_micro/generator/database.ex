defmodule QasMicro.Generator.Database do
  def render_repo(config_module) do
    QasMicro.Generator.Database.Repo.render(config_module)
  end

  def render_schema(config_module) do
    # TODO
    # No need to render schema for polymorphic
    config_module.object()
    |> Enum.filter(fn item -> !Map.get(item, :polymorphic, false) end)
    |> Enum.each(&QasMicro.Generator.Database.Schema.render(config_module, &1))
  end
end
