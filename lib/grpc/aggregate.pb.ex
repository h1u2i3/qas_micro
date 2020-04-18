defmodule QasMicro.QueryMessage do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          query: String.t()
        }
  defstruct [:query]

  field :query, 1, type: :string
end

defmodule QasMicro.CountResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          count: integer
        }
  defstruct [:count]

  field :count, 1, type: :int64
end

defmodule QasMicro.Aggregate.Service do
  @moduledoc false
  use GRPC.Service, name: "qas_micro.Aggregate"

  rpc :Count, QasMicro.QueryMessage, QasMicro.CountResult
end

defmodule QasMicro.Aggregate.Stub do
  @moduledoc false
  use GRPC.Stub, service: QasMicro.Aggregate.Service
end
