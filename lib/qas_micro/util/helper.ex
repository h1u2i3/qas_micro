defmodule QasMicro.Util.Helper do
  @moduledoc """
  Common helper methods
  """
  alias QasMicro.Util.Sigil, as: QSigil
  alias QasMicro.Util.Map, as: QMap

  @doc """
  Get value from map and convert it to atom
  """
  def get_atom_from_map(map, key) do
    value = Map.get(map, key)

    if is_nil(value) do
      nil
    else
      transform_to_atom(value)
    end
  end

  @doc """
  transform value to atom format
  """
  def transform_to_atom(value) when is_atom(value), do: value
  def transform_to_atom(value) when is_binary(value), do: String.to_atom(value)
  def transform_to_atom(_), do: raise("bad value, can't transform to atom")

  @doc """
  Convert keyword to map
  """
  def keyword_to_map([{_, _} | _] = keyword) do
    keyword
    |> Enum.map(&do_convert_map/1)
    |> Enum.into(%{})
  end

  def keyword_to_map([_ | _] = keyword) do
    Enum.map(keyword, &keyword_to_map/1)
  end

  def keyword_to_map(keyword), do: keyword

  defp do_convert_map({k, v}) when is_map(v) do
    {k, keyword_to_map(v)}
  end

  defp do_convert_map({k, v}) when is_list(v) do
    {k, keyword_to_map(v)}
  end

  defp do_convert_map(item), do: item

  @doc """
  Convert map to keyword list
  """
  def map_to_keyword(map) when is_map(map) do
    Enum.map(map, &do_convert_keyword/1)
  end

  def map_to_keyword(map) when is_list(map) do
    Enum.map(map, &map_to_keyword/1)
  end

  def map_to_keyword(map), do: map

  defp do_convert_keyword({k, v}) when is_atom(k) do
    {k, map_to_keyword(v)}
  end

  defp do_convert_keyword({k, v}) when is_binary(k) do
    {String.to_atom(k), map_to_keyword(v)}
  end

  @doc """
  Helper method to do pipe easy
  """
  def pipe_into(ast, position, value, f \\ & &1) do
    case value do
      value when value in [nil, []] ->
        ast

      _ ->
        value
        |> f.()
        |> map_to_keyword
        |> Macro.pipe(ast, position)
    end
  end

  @doc """
  Set application env if not exist env
  """
  def get_and_update_env(app, key, fun) do
    old_env = Application.get_env(app, key)
    Application.put_env(app, key, fun.(old_env))
    :ok
  end

  @doc """
  Get module atom from list string
  """
  def module_atom_from_list(list) do
    list
    |> Enum.map(&Macro.camelize/1)
    |> Module.concat()
  end

  @doc """
  Get config data from map or raise error
  """
  def get_value_or_raise(map, key) when is_map(map) do
    if value = Map.get(map, key) do
      value
    else
      raise "config error, must have #{key}"
    end
  end

  def get_value_or_raise(_map, _key) do
    raise "must be a map to fetch value"
  end

  @doc """
  Parse permission to authorize and action.
  """
  def parse_permission(:authorize, permission) do
    Map.keys(permission)
  end

  def parse_permission(:action, permission) do
    Enum.map(permission, fn
      {k, v} when v == true ->
        {k, v}

      {k, v} when is_binary(v) ->
        {k, QSigil.parse(v)}
    end)
  end

  @doc """
  Check plugin is enabled on object
  """
  def plugin_enabled?(object, plugin_name) do
    QMap.get(object, :"plugin.#{plugin_name}", false)
  end

  @doc """
  Get model name from module name
  """
  def model_name_from_module(module) do
    module
    |> Module.split()
    |> List.last()
    |> Macro.underscore()
  end

  def to_grpc_params(params) do
    keys =
      params
      |> Map.keys()
      |> Enum.join(",")

    Map.put(params, :keys, keys)
  end

  def to_ex_params(params) do
    keys = Map.get(params, :keys, "")

    atom_keys =
      keys
      |> String.split(",")
      |> Enum.map(&String.to_atom/1)

    Map.take(params, atom_keys)
  end
end
