defmodule QasMicro.Generator.Model.UUID do
  use QasMicroGenetator.Template

  alias QasMicro.Util.Unit

  def render(config_module, model_keys \\ nil) do
    model_keys =
      if model_keys do
        model_keys
      else
        config_module.parse_object()
        |> Enum.with_index(10)
        |> Enum.map(fn {o, index} ->
          {String.to_atom(o.name), index}
        end)
      end

    template()
    |> EEx.eval_string(uuid_module: config_module.uuid_module(), model_keys: Unit.new(model_keys))
    |> config_module.save_file("uuid.ex")
  end

  defp template do
    ~S"""
    defmodule <%= uuid_module %> do
      @model_keys <%= model_keys %>

      def unique_id(model) do
        timestamp = :os.system_time(:milli_seconds)
        "#{Map.get(@model_keys, model)}#{timestamp}#{Enum.random(100..999)}"
      end
    end
    """
  end
end
