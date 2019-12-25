defmodule QasMicro.Compiler.Middleware.Compiler do
  alias QasCore.Pipeline

  def call(%Pipeline{assigns: %{app: app, ebin_folder: ebin_folder}} = pipeline) do
    Code.compiler_options(ignore_module_conflict: true)

    # mkdir for the beam folder
    File.mkdir_p("#{ebin_folder}/beam/#{app}")

    {:ok, modules, _} =
      "#{ebin_folder}/src/#{app}/**/*.ex"
      |> Path.wildcard()
      |> Kernel.ParallelCompiler.compile_to_path(ebin_folder <> "/beam/#{app}")

    QasMicro.Cache.init_cache(app, modules)

    pipeline
  after
    Code.compiler_options(ignore_module_conflict: false)
  end
end
