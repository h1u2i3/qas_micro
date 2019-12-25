defmodule QasMicro.Code.Generator.Plugin.Socket do
  use QasMicro.Code.Genetator.Template

  def render(config_module) do
    app_name = config_module.name()
    app_socket_module = config_module.socket_module()
    app_guardian_module = config_module.guardian_module()

    """
    defmodule #{app_socket_module} do
      use Phoenix.Socket
      import Guardian.Phoenix.Socket

      def connect(params, origin_socket) do
        case authenticate(origin_socket, #{app_guardian_module}, Map.get(params, "token")) do
          {:ok, socket} ->
            resource = current_resource(socket)

            {
              :ok,
              Absinthe.Phoenix.Socket.put_options(socket,
                context: %{
                  __qas_app__: :#{app_name},
                  current_user: resource,
                  role: String.to_atom(resource.role)
                }
              )
            }

          {:error, _} ->
            {
              :ok,
              Absinthe.Phoenix.Socket.put_options(origin_socket,
                context: %{
                  __qas_app__: :#{app_name},
                  current_user: nil,
                  role: :visitor
                }
              )
            }
        end
      end

      def id(_socket), do: nil
    end
    """
    |> config_module.save_file("socket.ex")
  end
end
