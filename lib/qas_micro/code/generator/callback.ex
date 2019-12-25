defmodule QasMicro.Code.Generator.Callback do
  def render(config_module) do
    callback_module = config_module.callback_module()

    custom_callback =
      if Enum.member?(config_module.__info__(:functions), {:callback, 0}) do
        config_module.callback()
      else
        nil
      end

    template()
    |> EEx.eval_string(callback_module: callback_module, custom_callback: custom_callback)
    |> config_module.save_file("callback.ex")
  end

  def template do
    """
    defmodule <%= callback_module %> do
      require Logger

      <%= custom_callback %>

      def on_event(event, data) do
        Logger.info(inspect(event) <> " happend!, data is: " <> inspect(data))
      end
    end
    """
  end
end
