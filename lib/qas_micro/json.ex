defmodule QasMicro.Json do
  @behaviour Ecto.Type

  def type, do: :map

  def cast(map) when is_map(map), do: {:ok, map}
  def cast(_), do: :error

  def load(data) when is_map(data), do: Jason.encode(data)

  def dump(map) when is_map(map), do: {:ok, map}
end
