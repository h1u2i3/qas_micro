defmodule QasMicro.Parser do
  defmacro __using__(_opts) do
    quote do
      def __config_module__(app) when is_atom(app) do
        module_atom = QasMicro.Util.Helper.module_atom_from_list(["QasApp", "#{app}", "Config"])

        if :code.is_loaded(module_atom) do
          module_atom
        else
          started = QasMicro.Cache.start?(app)

          if !started do
            task = QasMicro.waiting_task(app)
            Task.await(task, :infinity)
          end

          module_atom
        end
      end

      def __config_module__(_), do: raise("app name should atom!")
    end
  end
end
