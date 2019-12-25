defmodule QasMicro.Database.Middleware.Seed do
  alias QasMicro.Pipeline

  import QasMicro.Util.Helper
  import Ecto.Query

  alias QasMicro.Util.Sigil, as: QSigil
  alias QasMicro.Util.Map, as: QMap

  def call(%Pipeline{assigns: %{config_module: config_module}} = pipeline) do
    repo_module = config_module.repo_module()

    try do
      repo_module.start_link()

      config_module.parse_object()
      |> Enum.each(fn object ->
        password = QMap.get(object, :"plugin.password")
        geometry = QMap.get(object, :"plugin.geometry")
        unique_number = QMap.get(object, :"plugin.unique_number")

        name = Map.get(object, :name)
        model_module = config_module.model_module(name)
        struct = model_module.new()
        callback_module = config_module.callback_module()

        searchable_fields =
          object
          |> Map.get(:field, [])
          |> Enum.filter(
            &(!Enum.member?([:file, :files, :json, :jsons], String.to_atom(&1.type)))
          )
          |> Enum.map(&String.to_atom(&1.name))

        object
        |> Map.get(:seed, [])
        |> Enum.each(fn seed ->
          {polymorphic, data_seed} = Map.pop(seed, :polymorphic)

          cast_model_module =
            if polymorphic do
              {Inflex.pluralize(polymorphic) <> "_" <> Inflex.pluralize(name), model_module}
            else
              model_module
            end

          if password do
            atom_list = Map.keys(data_seed) -- [:password, :password_confirmation]

            options =
              data_seed
              |> Map.take(atom_list)
              |> Enum.map(fn {k, v} -> {k, QSigil.parse(v)} end)
              |> map_to_keyword()

            model =
              cast_model_module
              |> generate_seed_query(Keyword.take(options, searchable_fields), geometry)
              |> repo_module.one()

            result =
              repo_module.transaction(fn ->
                model
                |> Kernel.||(struct)
                |> Ecto.Changeset.cast(data_seed, Map.keys(data_seed))
                |> model_module.generate_password_digest()
                |> generate_geometry(model_module, geometry)
                |> generate_unique_number(model_module, unique_number)
                |> repo_module.insert_or_update!
              end)

            callback_module.on_event(
              String.to_atom("#{name}_created"),
              Map.put(%{}, String.to_atom(name), result)
            )
          else
            cast_data_seed = Enum.map(data_seed, fn {k, v} -> {k, QSigil.parse(v)} end)

            model =
              cast_model_module
              |> generate_seed_query(Keyword.take(cast_data_seed, searchable_fields), geometry)
              |> repo_module.one()

            cast_struct =
              if model do
                model
              else
                if polymorphic do
                  polymorphic
                  |> config_module.model_module()
                  |> repo_module.get(Keyword.get(cast_data_seed, :assoc_id))
                  |> Ecto.build_assoc(name |> Inflex.pluralize() |> String.to_atom())
                else
                  struct
                end
              end

            cast_struct
            |> Ecto.Changeset.cast(keyword_to_map(cast_data_seed), Keyword.keys(cast_data_seed))
            |> case do
              nil ->
                nil

              changeset ->
                result =
                  repo_module.transaction(fn ->
                    changeset
                    |> generate_geometry(model_module, geometry)
                    |> generate_unique_number(model_module, unique_number)
                    |> repo_module.insert_or_update!()
                  end)

                callback_module.on_event(
                  String.to_atom("#{name}_created"),
                  Map.put(%{}, String.to_atom(name), result)
                )
            end
          end
        end)
      end)
    after
      repo_module.stop()
    end

    pipeline
  end

  defp generate_geometry(changeset, model_module, geometry) do
    if geometry do
      model_module.cast_geometry(changeset)
    else
      changeset
    end
  end

  defp generate_seed_query(query, params, geometry) do
    if geometry do
      Keyword.drop(params, [:lon, :lat])
    else
      params
    end
    |> Enum.reduce(query, fn {key, value}, query ->
      from(q in query, where: field(q, ^key) == ^value)
    end)
  end

  defp generate_unique_number(changeset, module, unique_number) do
    if unique_number do
      module.generate_unique_number(changeset)
    else
      changeset
    end
  end
end
