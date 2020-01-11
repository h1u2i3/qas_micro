defmodule QasMicro.Generator.Database.Schema do
  import QasMicro.Util.Helper

  alias QasMicro.Util.Unit
  alias QasMicro.Util.Map, as: QMap
  alias QasMicro.Util.Sigil, as: QSigil

  def render(config_module, object) do
    polymorphic = QMap.get(object, :"plugin.polymorphic")

    sub_table_headers =
      if polymorphic do
        QSigil.parse(polymorphic)
      else
        [nil]
      end

    Enum.each(sub_table_headers, &render_schema_template(config_module, object, &1))
  end

  defp render_schema_template(config_module, object, header) do
    timestamp = Map.get(object, :timestamp, true)
    primary_key = Map.get(object, :primary_key, true)
    schema_database = String.to_atom(config_module.env_database_name())

    schema_name =
      if header do
        header <> "_" <> get_value_or_raise(object, :name)
      else
        get_value_or_raise(object, :name)
      end

    schema_module = config_module.migration_module(schema_name)

    schema_table =
      if header do
        header <> "_" <> Map.get(object, :table_name, Inflex.pluralize(schema_name))
      else
        Map.get(object, :table_name, Inflex.pluralize(schema_name))
      end

    schema_template()
    |> EEx.eval_string(
      schema_module: schema_module,
      schema_database: Unit.new(schema_database),
      schema_table: schema_table,
      timestamp: timestamp,
      primary_key: primary_key,
      field_expressions: QasMicro.Generator.Database.Field.render(object),
      index_expressions: QasMicro.Generator.Database.Index.render(object, header)
    )
    |> config_module.save_file("#{schema_name}.ex", "migration")
  end

  defp schema_template do
    """
    defmodule <%= schema_module %> do
      use Yacto.Schema, dbname: <%= schema_database %>

      @primary_key {:id, :string, autogenerate: {UUID, :uuid4, []}}
      @primary_key_meta %{id: [size: 64]}

    <%= unless primary_key do %>
      @primary_key false
    <% end %>

      schema "<%= schema_table %>" do<%= for field <- field_expressions do %>
        <%= field %><% end %><%= for index <- index_expressions do %>
        <%= index %><% end %><%= if timestamp do %>
        timestamps(inserted_at: :created_at, type: :integer, autogenerate: {:os, :system_time, [:seconds]})
        <% end %>
      end
    end
    """
  end
end
