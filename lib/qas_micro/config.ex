defmodule QasMicro.Config.ConfigFetcher do
  require Logger

  def config(_app) do
    raise("you should set your own config_fetcher module to get the config from application")
  end

  def handle_sync_log(_app, _log) do
  end
end

defmodule QasMicro.Config do
  @moduledoc """
  Config for qas
  """

  @doc false
  def config do
    Keyword.merge(default_config(), Application.get_env(:qas_micro, Qas, []))
  end

  def options(app, assigns \\ %{}) do
    config = QasMicro.Config.config()

    %{
      app: app,
      assigns:
        Map.merge(assigns, %{
          ebin_folder: config[:ebin_folder],
          config_fetcher: config[:config_fetcher],
          save_to_file: config[:save_to_file],
          save_folder: config[:ebin_folder] <> "/src",
          database_config: config[:database_config],
          migration_app: config[:migration_app]
        })
    }
  end

  defp default_config do
    [
      # the way to get the config for the specific application
      config_fetcher: QasMicro.Config.ConfigFetcher,
      # save to file
      save_to_file: true,
      # the folder to save for the compiled beam file & source file
      ebin_folder: "ebin",
      # the database setting of the qas application
      database_config: [
        username: "postgres",
        hostname: "localhost",
        extensions: [{Geo.PostGIS.Extension, library: Geo}]
      ],
      # the migration app
      migration_app: nil
    ]
  end

  # use for every application config module
  defmacro __using__(config: config, keys: keys, options: options) do
    main_methods =
      quote do
        alias QasMicro.Util.Helper

        def config do
          unquote(config)
        end

        def options do
          unquote(options)
        end

        def parse_object do
          config()
          |> Map.get(:object, [])
          |> Enum.filter(&Map.get(&1, :parse, true))
        end

        def object(object_name) do
          config()
          |> Map.get(:object, [])
          |> Enum.find(&(Map.get(&1, :name) == object_name))
        end

        # add env to database name
        def env_database_name do
          "#{database_name()}_#{Mix.env()}"
        end

        def save_file(string, filename, sub_folder \\ nil, replace_origin \\ true) do
          case options().save_to_file do
            true ->
              root_folder = options().save_folder

              folder =
                if sub_folder do
                  Path.join([root_folder, name(), sub_folder])
                else
                  Path.join([root_folder, name()])
                end

              File.mkdir_p(folder)

              path = Path.join([folder, filename])

              if replace_origin do
                if !Helper.file_not_changed(path, cast_string) do
                  File.write!(path, Code.format_string!(string))
                  # File.write!(path, string)
                end
              else
                if !File.exists?(path) do
                  File.write!(path, Code.format_string!(string))
                end
              end

            false ->
              :ok
          end

          string
        end
      end

    [main_methods] ++
      root_module_methods() ++
      submodule_methods() ++
      config_key_methods(keys) ++
      object_key_methods() ++
      plugin_module_methods()
  end

  def config_key_methods(keys) do
    Enum.map(keys, fn name ->
      quote do
        def unquote(name)() do
          Map.get(config(), unquote(name))
        end
      end
    end)
  end

  def object_key_methods() do
    Enum.map([:field, :schema, :validation, :permission, :seed], fn name ->
      quote do
        def unquote(name)(object_name) do
          temp = object(object_name)

          cond do
            is_map(temp) -> Map.get(temp, unquote(name))
            true -> nil
          end
        end
      end
    end)
  end

  def root_module_methods do
    Enum.map(
      [
        "abilities",
        "api",
        "context",
        "guardian",
        "repo",
        "resolver",
        "schema",
        "callback",
        "wechat",
        "sms",
        "wechat_pay",
        "alipay",
        "qiniu",
        "socket",
        "global",
        {"uuid", "UUID"}
      ],
      fn
        {name, module_name} ->
          quote do
            def unquote(String.to_atom("#{name}_module"))() do
              Helper.module_atom_from_list(["QasApp", name(), unquote(module_name)])
            end
          end

        name ->
          quote do
            def unquote(String.to_atom("#{name}_module"))() do
              Helper.module_atom_from_list(["QasApp", name(), unquote(name)])
            end
          end
      end
    )
  end

  def submodule_methods do
    Enum.map(["middleware", "migration", "model", "schema"], fn name ->
      quote do
        def unquote(String.to_atom("#{name}_module"))(subname) do
          Helper.module_atom_from_list(["QasApp", name(), unquote(name), subname])
        end
      end
    end)
  end

  def plugin_module_methods do
    Enum.map(["model"], fn name ->
      quote do
        def unquote(String.to_atom("plugin_#{name}_module"))(subname) do
          Helper.module_atom_from_list(["QasApp", name(), "Plugin", unquote(name), subname])
        end
      end
    end)
  end
end
