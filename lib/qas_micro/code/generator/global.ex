defmodule QasMicro.Code.Generator.Global do
  def render(config_module) do
    global_module = config_module.global_module()

    global_code =
      if Enum.member?(config_module.__info__(:functions), {:global, 0}) do
        config_module.global()
      else
        nil
      end

    template()
    |> EEx.eval_string(global_module: global_module, global_code: global_code)
    |> config_module.save_file("global.ex")
  end

  def template do
    """
    defmodule <%= global_module %> do
      use QasMicro.Common.Global

      require Logger

      <%= global_code %>
    end
    """
  end
end
