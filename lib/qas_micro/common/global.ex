defmodule QasMicro.Common.Global do
  defmacro __using__(_opts) do
    quote do
      #
      # 处理全局的 context, 特殊需求
      #
      def context(_conn, res) do
        res
      end

      #
      # 处理全局的更改数据, 特殊需求
      #
      def input_args(_module, input, _res) do
        input
      end

      #
      # 全局 Model origin_query 处理
      #
      def origin_query(_module, query, _res) do
        query
      end

      defoverridable Module.definitions_in(__MODULE__, :def)
    end
  end
end
