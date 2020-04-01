defmodule QasMicro.Middleware.Config.Lexer do
  @moduledoc """
  Convert config file to elixir format
  """
  alias QasMicro.Pipeline

  def call(%Pipeline{assigns: %{config: config}} = pipeline) when is_binary(config) do
    with {:ok, tokens, _} <- :config_lexer.string(to_charlist(config)),
         {:ok, keywords} <- :config_parser.parse(tokens) do
      Pipeline.assign(pipeline, :config, keywords)
    else
      reason ->
        raise(reason)
    end
  end

  def call(_), do: raise("you must provide the right config string")
end
