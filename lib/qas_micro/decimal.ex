defmodule QasMicro.Decimal do
  use Ecto.Type

  alias Decimal, as: D

  def type, do: :decimal
  def cast(string) when is_binary(string), do: {:ok, D.new(string)}

  def cast(%Decimal{} = decimal), do: {:ok, decimal}

  def cast(_), do: :error

  def load(data), do: {:ok, D.to_string(data)}

  def dump(decimal), do: {:ok, decimal}
end
