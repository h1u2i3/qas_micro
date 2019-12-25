defmodule QasMicro.Worker do
  import QasMicro.Util.Helper

  @doc """
  直接运行后台任务
  """
  def run(application, queue \\ "default", worker, args, options \\ []) do
    worker_module = worker_module(application, worker)
    Exq.enqueue(Exq, queue, worker_module, args, options)
  end

  @doc """
  一段时间之后运行后台任务
  """
  def run_in(application, queue \\ "default", later, worker, args, options \\ []) do
    worker_module = worker_module(application, worker)
    Exq.enqueue(Exq, queue, later, worker_module, args, options)
  end

  @doc """
  某个时间运行后台任务
  """
  def run_at(application, queue \\ "default", time, worker, args, options \\ []) do
    worker_module = worker_module(application, worker)
    Exq.enqueue_at(Exq, queue, time, worker_module, args, options)
  end

  defp worker_module(application, worker) do
    module_atom_from_list([
      "QasApp",
      get_application_name(application),
      "Worker",
      "#{worker}_worker"
    ])
  end

  defp get_application_name(application) when is_binary(application) do
    application
  end

  defp get_application_name(application) when is_atom(application) do
    Atom.to_string(application)
  end
end
