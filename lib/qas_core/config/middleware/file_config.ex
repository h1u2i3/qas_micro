defmodule QasCore.Config.Middleware.FileConfig do
  alias QasCore.Pipeline

  def call(%Pipeline{assigns: %{path: path}} = pipeline) when is_binary(path) do
    with {:ok, body} <- File.read(path) do
      Pipeline.assign(pipeline, :config, body)
    else
      {:error, :enoent} ->
        raise("config file can't read, did it exist?")

      _ ->
        raise("load config file error")
    end
  end

  def call(_), do: raise("you must add path to the options if you choose file config parser")
end