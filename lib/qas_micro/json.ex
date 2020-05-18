defmodule QasMicro.Json do
  @behaviour Ecto.Type

  def type, do: :map

  def cast(map), do: map

  def load(data) when is_map(data), do: Jason.encode(data)

  def dump(map), do: {:ok, map}
end
