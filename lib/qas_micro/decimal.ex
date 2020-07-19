defmodule QasMicro.Decimal do
  use Ecto.Type

  alias Decimal, as: D

  def type, do: :decimal
  def cast(string) when is_binary(string), do: {:ok, string}
  def cast(%Decimal{} = decimal), do: {:ok, D.to_string(decimal)}
  def cast(_), do: :error

  def load(data), do: {:ok, D.to_string(data)}

  def dump(string) when is_binary(string), do: {:ok, D.new(string)}
  def dump(%Decimal{} = decimal), do: {:ok, decimal}
end
