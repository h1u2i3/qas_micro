defmodule QasMicro.Json do
  use Ecto.Type

  def type, do: :map

  def cast(map) when is_map(map) do
    case Jason.encode(map) do
      {:ok, string} -> {:ok, string}
      {:error, _} -> :error
    end
  end

  def cast(string) when is_binary(string), do: {:ok, string}

  def cast(_), do: :error

  def load(data) when is_map(data), do: Jason.encode(data)

  def dump(string) when is_binary(string), do: Jason.decode(string, keys: :atoms)
end

defmodule QasMicro.JsonArray do
  use Ecto.Type

  def type, do: {:array, :map}

  def cast(map) when is_map(map) do
    cast([map])
  end

  def cast(map) when is_list(map) do
    case Jason.encode(map) do
      {:ok, string} -> {:ok, string}
      {:error, _} -> :error
    end
  end

  def cast(string) when is_binary(string), do: {:ok, string}

  def cast(_), do: :error

  def load(data) when is_list(data), do: Jason.encode(data)

  def dump(string) when is_binary(string), do: Jason.decode(string, keys: :atoms)
end
