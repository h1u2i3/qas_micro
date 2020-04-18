defmodule QasMicro.CheckMessage do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          model: String.t(),
          id: String.t(),
          user_id: String.t()
        }
  defstruct [:model, :id, :user_id]

  field(:model, 1, type: :string)
  field(:id, 2, type: :string)
  field(:user_id, 3, type: :string)
end

defmodule QasMicro.CheckResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status: boolean
        }
  defstruct [:status]

  field(:status, 1, type: :bool)
end

defmodule QasMicro.Authority.Service do
  @moduledoc false
  use GRPC.Service, name: "qas_micro.Authority"

  rpc(:Check, QasMicro.CheckMessage, QasMicro.CheckResult)
  rpc(:SelfCHeck, QasMicro.CheckMessage, QasMicro.CheckResult)
end

defmodule QasMicro.Authority.Stub do
  @moduledoc false
  use GRPC.Stub, service: QasMicro.Authority.Service
end
