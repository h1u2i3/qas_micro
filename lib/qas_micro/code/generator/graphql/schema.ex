defmodule QasMicro.Code.Generator.Graphql.Schema do
  use QasMicro.Code.Genetator.Template

  import QasMicro.Util.Helper, only: [get_value_or_raise: 2]

  @external_resource Path.join(__DIR__, "schema.eex")

  def render(config_module) do
    object = config_module.parse_object()
    schema_module_name = config_module.schema_module()

    api_base = Application.get_env(:qas, :api_base, "http://localhost:4000/api")
    default_api_url = api_base <> "/" <> config_module.name()

    schema_type =
      Enum.map(object, fn item ->
        name = get_value_or_raise(item, :name)
        type_module_name = config_module.schema_module(name)
        "import_types(#{type_module_name})"
      end)

    type_query =
      Enum.map(object, fn item ->
        name = get_value_or_raise(item, :name)
        "import_fields(:#{name}_queries)"
      end)

    type_mutation =
      Enum.map(object, fn item ->
        name = get_value_or_raise(item, :name)
        "import_fields(:#{name}_mutations)"
      end)

    type_subscription =
      Enum.map(object, fn item ->
        name = get_value_or_raise(item, :name)
        "import_fields(:#{name}_subscriptions)"
      end)

    model_data_loader =
      Enum.map(object, fn item ->
        name = get_value_or_raise(item, :name)
        model_module_name = config_module.model_module(name)
        "|> Dataloader.add_source(#{model_module_name}, #{model_module_name}.data())"
      end)

    model_plural_query =
      Enum.map(object, fn item ->
        name = get_value_or_raise(item, :name)
        model_module_name = config_module.model_module(name)

        """
        def #{Inflex.pluralize(name)}_query(args, res \\\\ nil) do
          Enum.reduce(
            args,
            #{model_module_name}.origin_query(res),
            plural_query_reducer(#{model_module_name})
          )
        end
        """
      end)

    eex_template_string()
    |> EEx.eval_string(
      schema_module_name: schema_module_name,
      schema_type: schema_type,
      type_query: type_query,
      type_mutation: type_mutation,
      type_subscription: type_subscription,
      model_data_loader: model_data_loader,
      model_plural_query: model_plural_query,
      default_api_url: default_api_url
    )
    |> config_module.save_file("schema.ex")
  end
end
