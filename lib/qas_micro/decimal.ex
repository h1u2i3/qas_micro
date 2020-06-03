defmodule QasMicro.Decimal do
  @behaviour Ecto.Type

  alias Decimal, as: D

  def type, do: :decimal
  def cast(string) when is_binary(string), do: {:ok, string}

  def cast(_), do: :error

  def load(data), do: {:ok, D.to_string(data)}

  def dump(decimal), do: {:ok, decimal}
end
