defmodule QasMicro.Common.Middleware.Callback do
  alias QasMicro.Util.Helper

  def call(res, {application_name, event_name}) do
    if res.value && Enum.empty?(res.errors) do
      # TODO: should think did we still need the javascript callback module?
      # GenServer.call(
      #   QasMicro.Port,
      #   {:callback, Atom.to_string(application_name), Atom.to_string(event_name),
      #    Jason.encode!(res.value)}
      # )
      unless did_render_error(res.value) do
        callback_module =
          ["QasApp", Atom.to_string(application_name), "Callback"]
          |> Helper.module_atom_from_list()

        callback_module.on_event(event_name, res.value)
      end
    end

    res
  end

  def did_render_error(value) do
    Map.get(value, :status) == :error || Map.get(value, :error) || Map.get(value, :errors)
  end
end
