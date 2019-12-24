defmodule QasMicro.Compiler.Middleware.ModuleClean do
  alias QasMicro.Pipeline

  def call(%Pipeline{assigns: %{ebin_folder: ebin_folder, app: app}} = pipeline)
      when is_binary(ebin_folder) do
    # remove the module already in the memory
    paths = beam_wildcard(app, ebin_folder)

    paths
    |> Enum.map(fn file_path ->
      file_path |> Path.basename(".beam") |> String.to_atom()
    end)
    |> Enum.each(fn module ->
      :code.purge(module)
      :code.delete(module)
    end)

    # remove the code path in system
    Code.delete_path("#{ebin_folder}/beam/#{app}")

    # remove the module beam file
    ebin_folder
    |> Path.join("beam/#{app}")
    |> File.rm_rf!()

    pipeline
  end

  def call(_), do: raise("you must provide the ebin_folder to do the module clean operation")

  defp beam_wildcard(app, ebin_folder) do
    ebin_folder
    |> Path.join("beam/#{app}/*.beam")
    |> Path.wildcard()
  end
end
