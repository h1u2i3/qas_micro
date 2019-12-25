defmodule QasMicro.Code.Generator.Graphql do
  def render_type(config_module) do
    Enum.map(
      config_module.parse_object(),
      &QasMicro.Code.Generator.Graphql.Type.render(config_module, &1)
    )
  end

  def render_resolver(config_module) do
    QasMicro.Code.Generator.Graphql.Resolver.render(config_module)
  end

  def render_schema(config_module) do
    QasMicro.Code.Generator.Graphql.Schema.render(config_module)
  end
end
