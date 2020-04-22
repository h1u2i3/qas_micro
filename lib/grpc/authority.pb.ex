defmodule QasMicro.CheckMessage do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          model: String.t(),
          id: String.t(),
          user_id: String.t()
        }
  defstruct [:model, :id, :user_id]

  field :model, 1, type: :string
  field :id, 2, type: :string
  field :user_id, 3, type: :string
end

defmodule QasMicro.RelationCheckMessage do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          relation_table: String.t(),
          left_id_name: String.t(),
          left_id_value: String.t(),
          right_id_name: String.t(),
          right_id_value: String.t()
        }
  defstruct [:relation_table, :left_id_name, :left_id_value, :right_id_name, :right_id_value]

  field :relation_table, 1, type: :string
  field :left_id_name, 2, type: :string
  field :left_id_value, 3, type: :string
  field :right_id_name, 4, type: :string
  field :right_id_value, 5, type: :string
end

defmodule QasMicro.CheckResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status: boolean
        }
  defstruct [:status]

  field :status, 1, type: :bool
end

defmodule QasMicro.Authority.Service do
  @moduledoc false
  use GRPC.Service, name: "qas_micro.Authority"

  rpc :Check, QasMicro.CheckMessage, QasMicro.CheckResult
  rpc :SelfCheck, QasMicro.RelationCheckMessage, QasMicro.CheckResult
end

defmodule QasMicro.Authority.Stub do
  @moduledoc false
  use GRPC.Stub, service: QasMicro.Authority.Service
end
