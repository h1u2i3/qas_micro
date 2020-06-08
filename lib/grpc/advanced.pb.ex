defmodule QasMicro.QueryMessage do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query: String.t()
        }
  defstruct [:query]

  field(:query, 1, type: :string)
end

defmodule QasMicro.CountResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          count: integer
        }
  defstruct [:count]

  field(:count, 1, type: :int64)
end

defmodule QasMicro.QueryResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          result: String.t()
        }
  defstruct [:result]

  field(:result, 1, type: :string)
end

defmodule QasMicro.Advanced.Service do
  @moduledoc false
  use GRPC.Service, name: "qas_micro.Advanced"

  rpc(:Count, QasMicro.QueryMessage, QasMicro.CountResult)
  rpc(:Query, QasMicro.QueryMessage, QasMicro.QueryResult)
  rpc(:Update, QasMicro.QueryMessage, QasMicro.QueryResult)
  rpc(:Insert, QasMicro.QueryMessage, QasMicro.QueryResult)
end

defmodule QasMicro.Advanced.Stub do
  @moduledoc false
  use GRPC.Stub, service: QasMicro.Advanced.Service
end
