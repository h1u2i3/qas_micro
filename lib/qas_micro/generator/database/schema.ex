defmodule QasMicro.Generator.Database.Schema do
  import QasMicro.Util.Helper

  alias QasMicro.Util.Unit

  def render(config_module, object) do
    render_schema_template(config_module, object)
  end

  defp render_schema_template(config_module, object) do
    timestamp = Map.get(object, :timestamp, true)
    primary_key = Map.get(object, :primary_key, true)
    schema_database = String.to_atom(config_module.env_database_name())

    schema_name = get_value_or_raise(object, :name)

    schema_module = config_module.migration_module(schema_name)

    schema_table = Map.get(object, :table_name, Inflex.pluralize(schema_name))

    schema_template()
    |> EEx.eval_string(
      schema_module: schema_module,
      schema_database: Unit.new(schema_database),
      schema_table: schema_table,
      timestamp: timestamp,
      primary_key: primary_key,
      field_expressions: QasMicro.Generator.Database.Field.render(object, config_module),
      index_expressions: QasMicro.Generator.Database.Index.render(object)
    )
    |> config_module.save_file("#{schema_name}.ex", "migration")
  end

  defp schema_template do
    """
    defmodule <%= schema_module %> do
      use Yacto.Schema, dbname: <%= schema_database %>

    <%= if primary_key do %>
      @primary_key {:id, :string, autogenerate: {UUID, :uuid4, []}}
      @primary_key_meta %{id: [size: 64]}
    <% else %>
      @primary_key false
    <% end %>

      schema "<%= schema_table %>" do<%= for field <- field_expressions do %>
        <%= field %><% end %><%= for index <- index_expressions do %>
        <%= index %><% end %><%= if timestamp do %>

        timestamps(
          inserted_at: :created_at,
          type: :integer,
          meta: [type: :bigint],
          autogenerate: {:os, :system_time, [:milli_seconds]}
        )
        <% end %>
      end
    end
    """
  end
end
