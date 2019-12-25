defmodule QasMicro.Code.Genetator.Template do
  defmacro __using__(_opts) do
    quote do
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(env) do
    resources =
      env.module
      |> Module.get_attribute(:external_resource)
      |> List.wrap()

    template_map =
      Enum.map(resources, fn path ->
        {path |> Path.basename(".eex") |> String.to_atom(), File.read!(path)}
      end)

    quote do
      def eex_template_string, do: unquote(template_map) |> List.first() |> elem(1)
      def eex_template_string(key), do: Keyword.get(unquote(template_map), key)
    end
  end
end
