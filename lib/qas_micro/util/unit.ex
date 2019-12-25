defmodule QasMicro.Util.Unit do
  defstruct content: nil

  def new(content) do
    %__MODULE__{content: content}
  end

  defimpl String.Chars, for: __MODULE__ do
    def to_string(%{content: content}), do: Macro.to_string(content)
  end
end
