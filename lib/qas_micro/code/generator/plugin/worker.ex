defmodule QasMicro.Code.Generator.Plugin.Worker do
  use QasMicro.Code.Genetator.Template

  @external_resource Path.join(__DIR__, "worker.eex")

  def render(config_module) do
    worker_config =
      if(Enum.any?(config_module.__info__(:functions), &(elem(&1, 0) == :worker))) do
        config_module.worker()
      else
        %{}
      end

    Enum.each(worker_config, fn {key, code} ->
      application_name = config_module.name()
      worker_code = code

      worker_module_name =
        QasMicro.Util.Helper.module_atom_from_list([
          "QasApp",
          application_name,
          "Worker",
          "#{key}_worker"
        ])

      eex_template_string()
      |> EEx.eval_string(
        worker_code: worker_code,
        worker_module_name: worker_module_name
      )
      |> config_module.save_file("#{file_name(key)}.ex", "worker")
    end)
  end

  defp file_name(key) do
    "#{key}_worker"
  end
end
