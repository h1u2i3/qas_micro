defmodule QasCore.Code.Middleware.CodeClean do
  alias QasCore.Pipeline

  def call(%Pipeline{assigns: %{ebin_folder: ebin_folder, app: app}} = pipeline)
      when is_binary(ebin_folder) do
    # remove all the generated source code
    ebin_folder
    |> Path.join("src/#{app}")
    |> File.rm_rf!()

    pipeline
  end

  def call(_),
    do: raise("you must provide the ebin_folder to do the generated code clean operation")
end
