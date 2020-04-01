defmodule QasMicro.TransactionMessage do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          action: String.t(),
          input: String.t()
        }
  defstruct [:action, :input]

  field :action, 1, type: :string
  field :input, 2, type: :string
end

defmodule QasMicro.TransactionResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status: String.t(),
          result: String.t()
        }
  defstruct [:status, :result]

  field :status, 1, type: :string
  field :result, 2, type: :string
end

defmodule QasMicro.Transaction.Service do
  @moduledoc false
  use GRPC.Service, name: "qas_micro.Transaction"

  rpc :Transaction, stream(QasMicro.TransactionMessage), QasMicro.TransactionResult
end

defmodule QasMicro.Transaction.Stub do
  @moduledoc false
  use GRPC.Stub, service: QasMicro.Transaction.Service
end
