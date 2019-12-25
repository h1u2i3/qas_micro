defmodule Common.UserInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          app: String.t(),
          model: String.t(),
          id: integer
        }
  defstruct [:app, :model, :id]

  field(:app, 1, type: :string)
  field(:model, 2, type: :string)
  field(:id, 3, type: :int32)
end

defmodule Common.ID do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:id, :user]

  field(:id, 1, type: :string)
  field(:user, 2, type: Common.UserInfo)
end

defmodule Common.PaginateInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          limit: integer,
          offset: integer
        }
  defstruct [:limit, :offset]

  field(:limit, 1, type: :int32)
  field(:offset, 2, type: :int32)
end

defmodule Common.OrderItem.SortOrder do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field(:ASC, 0)
  field(:DESC, 1)
  field(:SPECIAL, 2)
end

defmodule Common.OrderItem do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          order: atom | integer
        }
  defstruct [:name, :order]

  field(:name, 1, type: :string)
  field(:order, 2, type: Common.OrderItem.SortOrder, enum: true)
end

defmodule Common.NormalError do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          message: String.t()
        }
  defstruct [:key, :message]

  field(:key, 1, type: :string)
  field(:message, 2, type: :string)
end

defmodule Common.ActionResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          status: String.t(),
          message: String.t()
        }
  defstruct [:status, :message]

  field(:status, 1, type: :string)
  field(:message, 2, type: :string)
end
