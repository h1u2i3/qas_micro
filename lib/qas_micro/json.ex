defmodule QasMicro.Json do
  @behaviour Ecto.Type

  def type, do: :map

  def cast(map) when is_map(map), do: {:ok, map}

  def cast(string) when is_binary(string) do
    case Jason.decode(string, keys: :atoms) do
      {:ok, map} -> {:ok, map}
      {:error, _} -> :error
    end
  end

  def cast(_), do: :error

  def load(data) when is_map(data), do: Jason.encode(data)

  def dump(map) when is_map(map), do: {:ok, map}
end

defmodule QasMicro.JsonArray do
  @behaviour Ecto.Type

  def type, do: {:array, :map}

  def cast(map) when is_map(map), do: {:ok, [map]}

  def cast(map) when is_list(map), do: {:ok, map}

  def cast(string) when is_binary(string) do
    case Jason.decode(string, keys: :atoms) do
      {:ok, map} -> cast(map)
      {:error, _} -> :error
    end
  end

  def cast(_), do: :error

  def load(data) when is_list(data), do: Jason.encode(data)

  def dump(map) when is_list(map), do: {:ok, map}
end
