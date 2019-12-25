defmodule QasMicro.Api.Middleware.StartApi do
  alias QasCore.Pipeline

  def call(
        %Pipeline{
          assigns: %{
            app: app,
            ebin_folder: ebin_folder,
            config_module: config_module
          }
        } = pipeline
      ) do
    Code.append_path("#{ebin_folder}/beam/#{app}")
    Supervisor.start_child(QasMicro.Supervisor, {config_module.api_module(), []})

    pipeline
  end
end
