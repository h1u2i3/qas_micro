defmodule QasMicro.Util.Map do
  @moduledoc """
  We need to support the map with keys operation
  like below:
  ```
    %{
      app_id: "abcdefghijklmn",
      biz_content: %{
        out_trade_no: "123456789",
        total_amount: "123"
      }
    }
  ```

  when we get keys:
  ```
  iex> Payment.Tool.BodyMap.keys(example)
  [:appid, :"biz_content.out_trade_no", :"biz_content.total_amount"]
  ```

  when we set the value:
  ```
  iex> Payment.Tool.BodyMap.put(example, :"biz_content.total_amount", "100")
  %{
    app_id: "abcdefghijklmn",
    biz_content: %{
      out_trade_no: "123456789",
      total_amount: "100"
    }
  }
  ```

  and when we get the value of the key:
  ```
  iex> Payment.Tool.BodyMap.get(example, :"biz_content.total_amount")
  "100"
  ```
  """

  @doc """
  Get the keys of the body_map
  """
  def keys(body_map) do
    body_map
    |> Enum.map(&get_key/1)
    |> List.flatten()
  end

  defp get_key({key, value}) when is_map(value) do
    value
    |> keys()
    |> Enum.map(&String.to_atom("#{key}.#{&1}"))
  end

  defp get_key({key, _value}), do: key

  @doc """
  Get value of the key from the body map
  """
  def get(body_map, key, default \\ nil) do
    value = get_in(body_map, access_key_list(key))

    case value do
      nil -> default
      _ -> value
    end
  end

  @doc """
  Set value only if the value is not nil
  """
  def put_non_null(body_map, key, value) do
    case value do
      nil -> body_map
      _ -> put(body_map, key, value)
    end
  end

  @doc """
  Set value to the key of the body map
  """
  def put(body_map, key, value) do
    put_in(body_map, access_key_list(key), value)
  end

  @doc """
  Take values fromt the body map
  """
  def take(body_map, key) when not is_list(key), do: take(body_map, [key])

  def take(body_map, key) do
    Enum.reduce(key, %{}, fn x, acc ->
      access = access_key_list(x)
      value = get_in(body_map, access)

      case value do
        nil -> acc
        _ -> put_in(acc, access, value)
      end
    end)
  end

  @doc """
  Drop the key and value in the map
  """
  def drop(body_map, key) when not is_list(key), do: drop(body_map, [key])

  def drop(body_map, key) do
    Enum.reduce(key, body_map, fn x, acc ->
      acc
      |> get_and_update_in(access_key_list(x), fn _ -> :pop end)
      |> elem(1)
    end)
  end

  defp access_key_list(key) do
    key
    |> Atom.to_string()
    |> String.split(".")
    |> Enum.map(&String.to_atom/1)
    |> Enum.reverse()
    |> gen_access_key_list([])
  end

  defp gen_access_key_list([], temp), do: temp

  defp gen_access_key_list([head | tail], []) do
    gen_access_key_list(tail, [Access.key(head)])
  end

  defp gen_access_key_list([head | tail], temp) do
    gen_access_key_list(tail, [Access.key(head, %{}) | temp])
  end
end
