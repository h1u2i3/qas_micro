defmodule QasMicro.Common.Schema.GeometryType do
  use Absinthe.Schema.Notation

  scalar :geometry, name: "Geometry" do
    serialize(&encode/1)
    parse(&decode/1)
  end

  defp decode(%Absinthe.Blueprint.Input.String{value: value}) do
    with {:ok, json} <- Poison.decode(value),
         {:ok, geo} <- Geo.JSON.decode(json) do
      {:ok, geo}
    else
      {:error, _datetime} -> :error
      _error -> :error
    end
  end

  defp decode(%Absinthe.Blueprint.Input.Null{}) do
    {:ok, nil}
  end

  defp decode(_) do
    :error
  end

  defp encode(value) do
    Geo.JSON.encode!(value)
  end
end
