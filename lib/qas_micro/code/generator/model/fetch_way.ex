defmodule QasMicro.Code.Generator.Model.FetchWay do
  def render(config_module, object) do
    object
    |> Map.get(:schema, [])
    |> Enum.filter(&Map.get(&1, :fetch_way))
    |> Enum.map(&render_single(config_module, &1))
  end

  defp render_single(_config_module, item) do
    name = Map.get(item, :name)
    fetch_way = Map.get(item, :fetch_way)

    """
    def fetch_way(:#{name}) do
      #{fetch_way}
    end
    """
  end
end
