defmodule Rancher.FilterRepoInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          sketches: String.t(),
          user_id: String.t(),
          price: String.t(),
          belongable_id: String.t(),
          belongable_type: String.t()
        }
  defstruct [:code, :sketches, :user_id, :price, :belongable_id, :belongable_type]

  field :code, 1, type: :string
  field :sketches, 2, type: :string
  field :user_id, 3, type: :string
  field :price, 4, type: :string
  field :belongable_id, 5, type: :string
  field :belongable_type, 6, type: :string
end

defmodule Rancher.ReposParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterRepoInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :user_ids]

  field :filter, 1, type: Rancher.FilterRepoInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :user_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateRepoInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          sketches: String.t(),
          user_id: integer,
          price: String.t(),
          belongable_id: integer,
          belongable_type: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :sketches, :user_id, :price, :belongable_id, :belongable_type, :user]

  field :code, 1, type: :string
  field :sketches, 2, type: :string
  field :user_id, 3, type: :int32
  field :price, 4, type: :string
  field :belongable_id, 5, type: :int32
  field :belongable_type, 6, type: :string
  field :user, 7, type: Common.UserInfo
end

defmodule Rancher.UpdateRepoInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          sketches: String.t(),
          user_id: integer,
          price: String.t(),
          belongable_id: integer,
          belongable_type: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :sketches, :user_id, :price, :belongable_id, :belongable_type, :user, :id]

  field :code, 1, type: :string
  field :sketches, 2, type: :string
  field :user_id, 3, type: :int32
  field :price, 4, type: :string
  field :belongable_id, 5, type: :int32
  field :belongable_type, 6, type: :string
  field :user, 7, type: Common.UserInfo
  field :id, 8, type: :int32
end

defmodule Rancher.Repo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          sketches: String.t(),
          user_id: integer,
          price: String.t(),
          belongable_id: integer,
          belongable_type: String.t(),
          user: Admin.User.t() | nil,
          repo_products: [Rancher.RepoProduct.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :sketches,
    :user_id,
    :price,
    :belongable_id,
    :belongable_type,
    :user,
    :repo_products,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :sketches, 3, type: :string
  field :user_id, 4, type: :int32
  field :price, 5, type: :string
  field :belongable_id, 6, type: :int32
  field :belongable_type, 7, type: :string
  field :user, 8, type: Admin.User
  field :repo_products, 9, repeated: true, type: Rancher.RepoProduct
  field :created_at, 10, type: :int32
  field :updated_at, 11, type: :int32
end

defmodule Rancher.Repos do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repos: [Rancher.Repo.t()]
        }
  defstruct [:repos]

  field :repos, 1, repeated: true, type: Rancher.Repo
end

defmodule Rancher.RepoResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo: Rancher.Repo.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:repo, :errors]

  field :repo, 1, type: Rancher.Repo
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterRoomInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          spec_id: String.t(),
          name: String.t(),
          rough: String.t(),
          precise: String.t(),
          area: String.t()
        }
  defstruct [:code, :spec_id, :name, :rough, :precise, :area]

  field :code, 1, type: :string
  field :spec_id, 2, type: :string
  field :name, 3, type: :string
  field :rough, 4, type: :string
  field :precise, 5, type: :string
  field :area, 6, type: :string
end

defmodule Rancher.RoomsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterRoomInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          spec_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :spec_ids]

  field :filter, 1, type: Rancher.FilterRoomInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :spec_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateRoomInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          spec_id: integer,
          name: String.t(),
          rough: String.t(),
          precise: String.t(),
          area: float | :infinity | :negative_infinity | :nan,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :spec_id, :name, :rough, :precise, :area, :user]

  field :code, 1, type: :string
  field :spec_id, 2, type: :int32
  field :name, 3, type: :string
  field :rough, 4, type: :string
  field :precise, 5, type: :string
  field :area, 6, type: :float
  field :user, 7, type: Common.UserInfo
end

defmodule Rancher.UpdateRoomInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          spec_id: integer,
          name: String.t(),
          rough: String.t(),
          precise: String.t(),
          area: float | :infinity | :negative_infinity | :nan,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :spec_id, :name, :rough, :precise, :area, :user, :id]

  field :code, 1, type: :string
  field :spec_id, 2, type: :int32
  field :name, 3, type: :string
  field :rough, 4, type: :string
  field :precise, 5, type: :string
  field :area, 6, type: :float
  field :user, 7, type: Common.UserInfo
  field :id, 8, type: :int32
end

defmodule Rancher.Room do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          spec_id: integer,
          name: String.t(),
          rough: String.t(),
          precise: String.t(),
          area: float | :infinity | :negative_infinity | :nan,
          spec: Rancher.Spec.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :spec_id,
    :name,
    :rough,
    :precise,
    :area,
    :spec,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :spec_id, 3, type: :int32
  field :name, 4, type: :string
  field :rough, 5, type: :string
  field :precise, 6, type: :string
  field :area, 7, type: :float
  field :spec, 8, type: Rancher.Spec
  field :created_at, 9, type: :int32
  field :updated_at, 10, type: :int32
end

defmodule Rancher.Rooms do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          rooms: [Rancher.Room.t()]
        }
  defstruct [:rooms]

  field :rooms, 1, repeated: true, type: Rancher.Room
end

defmodule Rancher.RoomResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          room: Rancher.Room.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:room, :errors]

  field :room, 1, type: Rancher.Room
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterSaledReviewInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          order_sale_id: String.t(),
          deadline_at: String.t(),
          user_id: String.t()
        }
  defstruct [:code, :order_sale_id, :deadline_at, :user_id]

  field :code, 1, type: :string
  field :order_sale_id, 2, type: :string
  field :deadline_at, 3, type: :string
  field :user_id, 4, type: :string
end

defmodule Rancher.SaledReviewsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterSaledReviewInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          order_sale_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :order_sale_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterSaledReviewInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :order_sale_ids, 6, repeated: true, type: :int32
  field :user_ids, 7, repeated: true, type: :int32
end

defmodule Rancher.CreateSaledReviewInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          order_sale_id: integer,
          deadline_at: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :order_sale_id, :deadline_at, :user_id, :user]

  field :code, 1, type: :string
  field :order_sale_id, 2, type: :int32
  field :deadline_at, 3, type: :int32
  field :user_id, 4, type: :int32
  field :user, 5, type: Common.UserInfo
end

defmodule Rancher.UpdateSaledReviewInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          order_sale_id: integer,
          deadline_at: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :order_sale_id, :deadline_at, :user_id, :user, :id]

  field :code, 1, type: :string
  field :order_sale_id, 2, type: :int32
  field :deadline_at, 3, type: :int32
  field :user_id, 4, type: :int32
  field :user, 5, type: Common.UserInfo
  field :id, 6, type: :int32
end

defmodule Rancher.SaledReview do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          order_sale_id: integer,
          deadline_at: integer,
          user_id: integer,
          order_sale: Rancher.OrderSale.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :order_sale_id,
    :deadline_at,
    :user_id,
    :order_sale,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :order_sale_id, 3, type: :int32
  field :deadline_at, 4, type: :int32
  field :user_id, 5, type: :int32
  field :order_sale, 6, type: Rancher.OrderSale
  field :user, 7, type: Admin.User
  field :created_at, 8, type: :int32
  field :updated_at, 9, type: :int32
end

defmodule Rancher.SaledReviews do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          saled_reviews: [Rancher.SaledReview.t()]
        }
  defstruct [:saled_reviews]

  field :saled_reviews, 1, repeated: true, type: Rancher.SaledReview
end

defmodule Rancher.SaledReviewResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          saled_review: Rancher.SaledReview.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:saled_review, :errors]

  field :saled_review, 1, type: Rancher.SaledReview
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterQuoteInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          spec_id: String.t(),
          case_id: String.t(),
          user_id: String.t(),
          remark: String.t()
        }
  defstruct [:code, :name, :spec_id, :case_id, :user_id, :remark]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :spec_id, 3, type: :string
  field :case_id, 4, type: :string
  field :user_id, 5, type: :string
  field :remark, 6, type: :string
end

defmodule Rancher.QuotesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterQuoteInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          spec_ids: [integer],
          case_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :spec_ids, :case_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterQuoteInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :spec_ids, 6, repeated: true, type: :int32
  field :case_ids, 7, repeated: true, type: :int32
  field :user_ids, 8, repeated: true, type: :int32
end

defmodule Rancher.CreateQuoteInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          spec_id: integer,
          case_id: integer,
          user_id: integer,
          remark: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :name, :spec_id, :case_id, :user_id, :remark, :user]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :spec_id, 3, type: :int32
  field :case_id, 4, type: :int32
  field :user_id, 5, type: :int32
  field :remark, 6, type: :string
  field :user, 7, type: Common.UserInfo
end

defmodule Rancher.UpdateQuoteInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          spec_id: integer,
          case_id: integer,
          user_id: integer,
          remark: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :name, :spec_id, :case_id, :user_id, :remark, :user, :id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :spec_id, 3, type: :int32
  field :case_id, 4, type: :int32
  field :user_id, 5, type: :int32
  field :remark, 6, type: :string
  field :user, 7, type: Common.UserInfo
  field :id, 8, type: :int32
end

defmodule Rancher.Quote do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          name: String.t(),
          spec_id: integer,
          case_id: integer,
          user_id: integer,
          remark: String.t(),
          spec: Rancher.Spec.t() | nil,
          case: Rancher.Case.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :name,
    :spec_id,
    :case_id,
    :user_id,
    :remark,
    :spec,
    :case,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :name, 3, type: :string
  field :spec_id, 4, type: :int32
  field :case_id, 5, type: :int32
  field :user_id, 6, type: :int32
  field :remark, 7, type: :string
  field :spec, 8, type: Rancher.Spec
  field :case, 9, type: Rancher.Case
  field :user, 10, type: Admin.User
  field :created_at, 11, type: :int32
  field :updated_at, 12, type: :int32
end

defmodule Rancher.Quotes do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          quotes: [Rancher.Quote.t()]
        }
  defstruct [:quotes]

  field :quotes, 1, repeated: true, type: Rancher.Quote
end

defmodule Rancher.QuoteResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          quote: Rancher.Quote.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:quote, :errors]

  field :quote, 1, type: Rancher.Quote
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterTicketInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          house_id: String.t(),
          customer_type: String.t(),
          customer_tags: String.t(),
          expect_arrive_at: String.t(),
          arrived_at: String.t(),
          status: String.t(),
          user_id: String.t()
        }
  defstruct [
    :code,
    :house_id,
    :customer_type,
    :customer_tags,
    :expect_arrive_at,
    :arrived_at,
    :status,
    :user_id
  ]

  field :code, 1, type: :string
  field :house_id, 2, type: :string
  field :customer_type, 3, type: :string
  field :customer_tags, 4, type: :string
  field :expect_arrive_at, 5, type: :string
  field :arrived_at, 6, type: :string
  field :status, 7, type: :string
  field :user_id, 8, type: :string
end

defmodule Rancher.TicketsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterTicketInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          house_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :house_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterTicketInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :house_ids, 6, repeated: true, type: :int32
  field :user_ids, 7, repeated: true, type: :int32
end

defmodule Rancher.CreateTicketInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          house_id: integer,
          customer_type: String.t(),
          customer_tags: String.t(),
          expect_arrive_at: integer,
          arrived_at: integer,
          status: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :code,
    :house_id,
    :customer_type,
    :customer_tags,
    :expect_arrive_at,
    :arrived_at,
    :status,
    :user_id,
    :user
  ]

  field :code, 1, type: :string
  field :house_id, 2, type: :int32
  field :customer_type, 3, type: :string
  field :customer_tags, 4, type: :string
  field :expect_arrive_at, 5, type: :int32
  field :arrived_at, 6, type: :int32
  field :status, 7, type: :int32
  field :user_id, 8, type: :int32
  field :user, 9, type: Common.UserInfo
end

defmodule Rancher.UpdateTicketInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          house_id: integer,
          customer_type: String.t(),
          customer_tags: String.t(),
          expect_arrive_at: integer,
          arrived_at: integer,
          status: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :code,
    :house_id,
    :customer_type,
    :customer_tags,
    :expect_arrive_at,
    :arrived_at,
    :status,
    :user_id,
    :user,
    :id
  ]

  field :code, 1, type: :string
  field :house_id, 2, type: :int32
  field :customer_type, 3, type: :string
  field :customer_tags, 4, type: :string
  field :expect_arrive_at, 5, type: :int32
  field :arrived_at, 6, type: :int32
  field :status, 7, type: :int32
  field :user_id, 8, type: :int32
  field :user, 9, type: Common.UserInfo
  field :id, 10, type: :int32
end

defmodule Rancher.Ticket do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          house_id: integer,
          customer_type: String.t(),
          customer_tags: String.t(),
          expect_arrive_at: integer,
          arrived_at: integer,
          status: integer,
          user_id: integer,
          house: Rancher.House.t() | nil,
          user: Admin.User.t() | nil,
          stories: [Rancher.Story.t()],
          traces: [Rancher.Trace.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :house_id,
    :customer_type,
    :customer_tags,
    :expect_arrive_at,
    :arrived_at,
    :status,
    :user_id,
    :house,
    :user,
    :stories,
    :traces,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :house_id, 3, type: :int32
  field :customer_type, 4, type: :string
  field :customer_tags, 5, type: :string
  field :expect_arrive_at, 6, type: :int32
  field :arrived_at, 7, type: :int32
  field :status, 8, type: :int32
  field :user_id, 9, type: :int32
  field :house, 10, type: Rancher.House
  field :user, 11, type: Admin.User
  field :stories, 12, repeated: true, type: Rancher.Story
  field :traces, 13, repeated: true, type: Rancher.Trace
  field :created_at, 14, type: :int32
  field :updated_at, 15, type: :int32
end

defmodule Rancher.Tickets do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tickets: [Rancher.Ticket.t()]
        }
  defstruct [:tickets]

  field :tickets, 1, repeated: true, type: Rancher.Ticket
end

defmodule Rancher.TicketResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          ticket: Rancher.Ticket.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:ticket, :errors]

  field :ticket, 1, type: Rancher.Ticket
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterTraceInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          ticket_id: String.t(),
          customer_id: String.t(),
          confirmed_at: String.t(),
          arrived_at: String.t(),
          user_id: String.t(),
          remark: String.t()
        }
  defstruct [:code, :ticket_id, :customer_id, :confirmed_at, :arrived_at, :user_id, :remark]

  field :code, 1, type: :string
  field :ticket_id, 2, type: :string
  field :customer_id, 3, type: :string
  field :confirmed_at, 4, type: :string
  field :arrived_at, 5, type: :string
  field :user_id, 6, type: :string
  field :remark, 7, type: :string
end

defmodule Rancher.TracesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterTraceInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          ticket_ids: [integer],
          customer_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :ticket_ids, :customer_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterTraceInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :ticket_ids, 6, repeated: true, type: :int32
  field :customer_ids, 7, repeated: true, type: :int32
  field :user_ids, 8, repeated: true, type: :int32
end

defmodule Rancher.CreateTraceInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          ticket_id: integer,
          customer_id: integer,
          confirmed_at: integer,
          arrived_at: integer,
          user_id: integer,
          remark: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :code,
    :ticket_id,
    :customer_id,
    :confirmed_at,
    :arrived_at,
    :user_id,
    :remark,
    :user
  ]

  field :code, 1, type: :string
  field :ticket_id, 2, type: :int32
  field :customer_id, 3, type: :int32
  field :confirmed_at, 4, type: :int32
  field :arrived_at, 5, type: :int32
  field :user_id, 6, type: :int32
  field :remark, 7, type: :string
  field :user, 8, type: Common.UserInfo
end

defmodule Rancher.UpdateTraceInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          ticket_id: integer,
          customer_id: integer,
          confirmed_at: integer,
          arrived_at: integer,
          user_id: integer,
          remark: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :code,
    :ticket_id,
    :customer_id,
    :confirmed_at,
    :arrived_at,
    :user_id,
    :remark,
    :user,
    :id
  ]

  field :code, 1, type: :string
  field :ticket_id, 2, type: :int32
  field :customer_id, 3, type: :int32
  field :confirmed_at, 4, type: :int32
  field :arrived_at, 5, type: :int32
  field :user_id, 6, type: :int32
  field :remark, 7, type: :string
  field :user, 8, type: Common.UserInfo
  field :id, 9, type: :int32
end

defmodule Rancher.Trace do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          ticket_id: integer,
          customer_id: integer,
          confirmed_at: integer,
          arrived_at: integer,
          user_id: integer,
          remark: String.t(),
          ticket: Rancher.Ticket.t() | nil,
          customer: Rancher.Customer.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :ticket_id,
    :customer_id,
    :confirmed_at,
    :arrived_at,
    :user_id,
    :remark,
    :ticket,
    :customer,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :ticket_id, 3, type: :int32
  field :customer_id, 4, type: :int32
  field :confirmed_at, 5, type: :int32
  field :arrived_at, 6, type: :int32
  field :user_id, 7, type: :int32
  field :remark, 8, type: :string
  field :ticket, 9, type: Rancher.Ticket
  field :customer, 10, type: Rancher.Customer
  field :user, 11, type: Admin.User
  field :created_at, 12, type: :int32
  field :updated_at, 13, type: :int32
end

defmodule Rancher.Traces do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          traces: [Rancher.Trace.t()]
        }
  defstruct [:traces]

  field :traces, 1, repeated: true, type: Rancher.Trace
end

defmodule Rancher.TraceResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          trace: Rancher.Trace.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:trace, :errors]

  field :trace, 1, type: Rancher.Trace
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterOrderInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          trace_id: String.t(),
          house_address: String.t(),
          sign_at: String.t(),
          expect_hand_over_at: String.t(),
          cooperated_period: String.t(),
          customer_id: String.t(),
          price: String.t(),
          price_cn: String.t(),
          price_off: String.t(),
          price_off_cn: String.t(),
          paid_percent: String.t(),
          status: String.t(),
          user_id: String.t()
        }
  defstruct [
    :code,
    :trace_id,
    :house_address,
    :sign_at,
    :expect_hand_over_at,
    :cooperated_period,
    :customer_id,
    :price,
    :price_cn,
    :price_off,
    :price_off_cn,
    :paid_percent,
    :status,
    :user_id
  ]

  field :code, 1, type: :string
  field :trace_id, 2, type: :string
  field :house_address, 3, type: :string
  field :sign_at, 4, type: :string
  field :expect_hand_over_at, 5, type: :string
  field :cooperated_period, 6, type: :string
  field :customer_id, 7, type: :string
  field :price, 8, type: :string
  field :price_cn, 9, type: :string
  field :price_off, 10, type: :string
  field :price_off_cn, 11, type: :string
  field :paid_percent, 12, type: :string
  field :status, 13, type: :string
  field :user_id, 14, type: :string
end

defmodule Rancher.OrdersParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterOrderInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          trace_ids: [integer],
          customer_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :trace_ids, :customer_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterOrderInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :trace_ids, 6, repeated: true, type: :int32
  field :customer_ids, 7, repeated: true, type: :int32
  field :user_ids, 8, repeated: true, type: :int32
end

defmodule Rancher.CreateOrderInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          trace_id: integer,
          house_address: String.t(),
          sign_at: integer,
          expect_hand_over_at: integer,
          cooperated_period: String.t(),
          customer_id: integer,
          price: String.t(),
          price_cn: String.t(),
          price_off: String.t(),
          price_off_cn: String.t(),
          paid_percent: String.t(),
          status: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :code,
    :trace_id,
    :house_address,
    :sign_at,
    :expect_hand_over_at,
    :cooperated_period,
    :customer_id,
    :price,
    :price_cn,
    :price_off,
    :price_off_cn,
    :paid_percent,
    :status,
    :user_id,
    :user
  ]

  field :code, 1, type: :string
  field :trace_id, 2, type: :int32
  field :house_address, 3, type: :string
  field :sign_at, 4, type: :int32
  field :expect_hand_over_at, 5, type: :int32
  field :cooperated_period, 6, type: :string
  field :customer_id, 7, type: :int32
  field :price, 8, type: :string
  field :price_cn, 9, type: :string
  field :price_off, 10, type: :string
  field :price_off_cn, 11, type: :string
  field :paid_percent, 12, type: :string
  field :status, 13, type: :int32
  field :user_id, 14, type: :int32
  field :user, 15, type: Common.UserInfo
end

defmodule Rancher.UpdateOrderInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          trace_id: integer,
          house_address: String.t(),
          sign_at: integer,
          expect_hand_over_at: integer,
          cooperated_period: String.t(),
          customer_id: integer,
          price: String.t(),
          price_cn: String.t(),
          price_off: String.t(),
          price_off_cn: String.t(),
          paid_percent: String.t(),
          status: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :code,
    :trace_id,
    :house_address,
    :sign_at,
    :expect_hand_over_at,
    :cooperated_period,
    :customer_id,
    :price,
    :price_cn,
    :price_off,
    :price_off_cn,
    :paid_percent,
    :status,
    :user_id,
    :user,
    :id
  ]

  field :code, 1, type: :string
  field :trace_id, 2, type: :int32
  field :house_address, 3, type: :string
  field :sign_at, 4, type: :int32
  field :expect_hand_over_at, 5, type: :int32
  field :cooperated_period, 6, type: :string
  field :customer_id, 7, type: :int32
  field :price, 8, type: :string
  field :price_cn, 9, type: :string
  field :price_off, 10, type: :string
  field :price_off_cn, 11, type: :string
  field :paid_percent, 12, type: :string
  field :status, 13, type: :int32
  field :user_id, 14, type: :int32
  field :user, 15, type: Common.UserInfo
  field :id, 16, type: :int32
end

defmodule Rancher.Order do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          trace_id: integer,
          house_address: String.t(),
          sign_at: integer,
          expect_hand_over_at: integer,
          cooperated_period: String.t(),
          customer_id: integer,
          price: String.t(),
          price_cn: String.t(),
          price_off: String.t(),
          price_off_cn: String.t(),
          paid_percent: String.t(),
          status: integer,
          user_id: integer,
          trace: Rancher.Trace.t() | nil,
          customer: Rancher.Customer.t() | nil,
          user: Admin.User.t() | nil,
          payments: [Rancher.Payment.t()],
          order_purchase_plans: [Rancher.OrderPurchasePlan.t()],
          order_deal_plans: [Rancher.OrderDealPlan.t()],
          order_sales: [Rancher.OrderSale.t()],
          order_bills: [Rancher.OrderBill.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :trace_id,
    :house_address,
    :sign_at,
    :expect_hand_over_at,
    :cooperated_period,
    :customer_id,
    :price,
    :price_cn,
    :price_off,
    :price_off_cn,
    :paid_percent,
    :status,
    :user_id,
    :trace,
    :customer,
    :user,
    :payments,
    :order_purchase_plans,
    :order_deal_plans,
    :order_sales,
    :order_bills,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :trace_id, 3, type: :int32
  field :house_address, 4, type: :string
  field :sign_at, 5, type: :int32
  field :expect_hand_over_at, 6, type: :int32
  field :cooperated_period, 7, type: :string
  field :customer_id, 8, type: :int32
  field :price, 9, type: :string
  field :price_cn, 10, type: :string
  field :price_off, 11, type: :string
  field :price_off_cn, 12, type: :string
  field :paid_percent, 13, type: :string
  field :status, 14, type: :int32
  field :user_id, 15, type: :int32
  field :trace, 16, type: Rancher.Trace
  field :customer, 17, type: Rancher.Customer
  field :user, 18, type: Admin.User
  field :payments, 19, repeated: true, type: Rancher.Payment
  field :order_purchase_plans, 20, repeated: true, type: Rancher.OrderPurchasePlan
  field :order_deal_plans, 21, repeated: true, type: Rancher.OrderDealPlan
  field :order_sales, 22, repeated: true, type: Rancher.OrderSale
  field :order_bills, 23, repeated: true, type: Rancher.OrderBill
  field :created_at, 24, type: :int32
  field :updated_at, 25, type: :int32
end

defmodule Rancher.Orders do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          orders: [Rancher.Order.t()]
        }
  defstruct [:orders]

  field :orders, 1, repeated: true, type: Rancher.Order
end

defmodule Rancher.OrderResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order: Rancher.Order.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:order, :errors]

  field :order, 1, type: Rancher.Order
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterOrderDealPlanInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          order_id: String.t(),
          name: String.t(),
          start_at: String.t(),
          end_at: String.t(),
          actual_start_at: String.t(),
          actual_end_at: String.t(),
          worker_name: String.t(),
          worker_cellphone: String.t(),
          status: String.t(),
          vouchers: String.t(),
          user_id: String.t(),
          responser_id: String.t()
        }
  defstruct [
    :code,
    :order_id,
    :name,
    :start_at,
    :end_at,
    :actual_start_at,
    :actual_end_at,
    :worker_name,
    :worker_cellphone,
    :status,
    :vouchers,
    :user_id,
    :responser_id
  ]

  field :code, 1, type: :string
  field :order_id, 2, type: :string
  field :name, 3, type: :string
  field :start_at, 4, type: :string
  field :end_at, 5, type: :string
  field :actual_start_at, 6, type: :string
  field :actual_end_at, 7, type: :string
  field :worker_name, 8, type: :string
  field :worker_cellphone, 9, type: :string
  field :status, 10, type: :string
  field :vouchers, 11, type: :string
  field :user_id, 12, type: :string
  field :responser_id, 13, type: :string
end

defmodule Rancher.OrderDealPlansParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterOrderDealPlanInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          order_ids: [integer],
          user_ids: [integer],
          responser_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :order_ids, :user_ids, :responser_ids]

  field :filter, 1, type: Rancher.FilterOrderDealPlanInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :order_ids, 6, repeated: true, type: :int32
  field :user_ids, 7, repeated: true, type: :int32
  field :responser_ids, 8, repeated: true, type: :int32
end

defmodule Rancher.CreateOrderDealPlanInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          order_id: integer,
          name: String.t(),
          start_at: integer,
          end_at: integer,
          actual_start_at: integer,
          actual_end_at: integer,
          worker_name: String.t(),
          worker_cellphone: String.t(),
          status: integer,
          vouchers: String.t(),
          user_id: integer,
          responser_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :code,
    :order_id,
    :name,
    :start_at,
    :end_at,
    :actual_start_at,
    :actual_end_at,
    :worker_name,
    :worker_cellphone,
    :status,
    :vouchers,
    :user_id,
    :responser_id,
    :user
  ]

  field :code, 1, type: :string
  field :order_id, 2, type: :int32
  field :name, 3, type: :string
  field :start_at, 4, type: :int32
  field :end_at, 5, type: :int32
  field :actual_start_at, 6, type: :int32
  field :actual_end_at, 7, type: :int32
  field :worker_name, 8, type: :string
  field :worker_cellphone, 9, type: :string
  field :status, 10, type: :int32
  field :vouchers, 11, type: :string
  field :user_id, 12, type: :int32
  field :responser_id, 13, type: :int32
  field :user, 14, type: Common.UserInfo
end

defmodule Rancher.UpdateOrderDealPlanInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          order_id: integer,
          name: String.t(),
          start_at: integer,
          end_at: integer,
          actual_start_at: integer,
          actual_end_at: integer,
          worker_name: String.t(),
          worker_cellphone: String.t(),
          status: integer,
          vouchers: String.t(),
          user_id: integer,
          responser_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :code,
    :order_id,
    :name,
    :start_at,
    :end_at,
    :actual_start_at,
    :actual_end_at,
    :worker_name,
    :worker_cellphone,
    :status,
    :vouchers,
    :user_id,
    :responser_id,
    :user,
    :id
  ]

  field :code, 1, type: :string
  field :order_id, 2, type: :int32
  field :name, 3, type: :string
  field :start_at, 4, type: :int32
  field :end_at, 5, type: :int32
  field :actual_start_at, 6, type: :int32
  field :actual_end_at, 7, type: :int32
  field :worker_name, 8, type: :string
  field :worker_cellphone, 9, type: :string
  field :status, 10, type: :int32
  field :vouchers, 11, type: :string
  field :user_id, 12, type: :int32
  field :responser_id, 13, type: :int32
  field :user, 14, type: Common.UserInfo
  field :id, 15, type: :int32
end

defmodule Rancher.OrderDealPlan do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          order_id: integer,
          name: String.t(),
          start_at: integer,
          end_at: integer,
          actual_start_at: integer,
          actual_end_at: integer,
          worker_name: String.t(),
          worker_cellphone: String.t(),
          status: integer,
          vouchers: String.t(),
          user_id: integer,
          responser_id: integer,
          order: Rancher.Order.t() | nil,
          user: Admin.User.t() | nil,
          responser: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :order_id,
    :name,
    :start_at,
    :end_at,
    :actual_start_at,
    :actual_end_at,
    :worker_name,
    :worker_cellphone,
    :status,
    :vouchers,
    :user_id,
    :responser_id,
    :order,
    :user,
    :responser,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :order_id, 3, type: :int32
  field :name, 4, type: :string
  field :start_at, 5, type: :int32
  field :end_at, 6, type: :int32
  field :actual_start_at, 7, type: :int32
  field :actual_end_at, 8, type: :int32
  field :worker_name, 9, type: :string
  field :worker_cellphone, 10, type: :string
  field :status, 11, type: :int32
  field :vouchers, 12, type: :string
  field :user_id, 13, type: :int32
  field :responser_id, 14, type: :int32
  field :order, 15, type: Rancher.Order
  field :user, 16, type: Admin.User
  field :responser, 17, type: Admin.User
  field :created_at, 18, type: :int32
  field :updated_at, 19, type: :int32
end

defmodule Rancher.OrderDealPlans do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_deal_plans: [Rancher.OrderDealPlan.t()]
        }
  defstruct [:order_deal_plans]

  field :order_deal_plans, 1, repeated: true, type: Rancher.OrderDealPlan
end

defmodule Rancher.OrderDealPlanResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_deal_plan: Rancher.OrderDealPlan.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:order_deal_plan, :errors]

  field :order_deal_plan, 1, type: Rancher.OrderDealPlan
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterOrderDealInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_product_id: String.t(),
          order_deal_plan_id: String.t()
        }
  defstruct [:repo_product_id, :order_deal_plan_id]

  field :repo_product_id, 1, type: :string
  field :order_deal_plan_id, 2, type: :string
end

defmodule Rancher.OrderDealsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterOrderDealInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          order_deal_plan_ids: [integer],
          repo_product_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :order_deal_plan_ids, :repo_product_ids]

  field :filter, 1, type: Rancher.FilterOrderDealInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :order_deal_plan_ids, 6, repeated: true, type: :int32
  field :repo_product_ids, 7, repeated: true, type: :int32
end

defmodule Rancher.CreateOrderDealInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_product_id: integer,
          order_deal_plan_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:repo_product_id, :order_deal_plan_id, :user]

  field :repo_product_id, 1, type: :int32
  field :order_deal_plan_id, 2, type: :int32
  field :user, 3, type: Common.UserInfo
end

defmodule Rancher.UpdateOrderDealInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_product_id: integer,
          order_deal_plan_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:repo_product_id, :order_deal_plan_id, :user, :id]

  field :repo_product_id, 1, type: :int32
  field :order_deal_plan_id, 2, type: :int32
  field :user, 3, type: Common.UserInfo
  field :id, 4, type: :int32
end

defmodule Rancher.OrderDeal do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          repo_product_id: integer,
          order_deal_plan_id: integer,
          order_deal_plan: Rancher.OrderDealPlan.t() | nil,
          repo_product: Rancher.RepoProduct.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :repo_product_id,
    :order_deal_plan_id,
    :order_deal_plan,
    :repo_product,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :repo_product_id, 2, type: :int32
  field :order_deal_plan_id, 3, type: :int32
  field :order_deal_plan, 4, type: Rancher.OrderDealPlan
  field :repo_product, 5, type: Rancher.RepoProduct
  field :created_at, 6, type: :int32
  field :updated_at, 7, type: :int32
end

defmodule Rancher.OrderDeals do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_deals: [Rancher.OrderDeal.t()]
        }
  defstruct [:order_deals]

  field :order_deals, 1, repeated: true, type: Rancher.OrderDeal
end

defmodule Rancher.OrderDealResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_deal: Rancher.OrderDeal.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:order_deal, :errors]

  field :order_deal, 1, type: Rancher.OrderDeal
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterOrderPurchasePlanInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          order_id: String.t(),
          vendor_id: String.t(),
          repo_product_id: String.t(),
          status: String.t(),
          vouchers: String.t(),
          user_id: String.t()
        }
  defstruct [:code, :order_id, :vendor_id, :repo_product_id, :status, :vouchers, :user_id]

  field :code, 1, type: :string
  field :order_id, 2, type: :string
  field :vendor_id, 3, type: :string
  field :repo_product_id, 4, type: :string
  field :status, 5, type: :string
  field :vouchers, 6, type: :string
  field :user_id, 7, type: :string
end

defmodule Rancher.OrderPurchasePlansParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterOrderPurchasePlanInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          order_ids: [integer],
          vendor_ids: [integer],
          repo_product_ids: [integer],
          user_ids: [integer]
        }
  defstruct [
    :filter,
    :order,
    :paginate,
    :user,
    :ids,
    :order_ids,
    :vendor_ids,
    :repo_product_ids,
    :user_ids
  ]

  field :filter, 1, type: Rancher.FilterOrderPurchasePlanInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :order_ids, 6, repeated: true, type: :int32
  field :vendor_ids, 7, repeated: true, type: :int32
  field :repo_product_ids, 8, repeated: true, type: :int32
  field :user_ids, 9, repeated: true, type: :int32
end

defmodule Rancher.CreateOrderPurchasePlanInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          order_id: integer,
          vendor_id: integer,
          repo_product_id: integer,
          status: integer,
          vouchers: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :order_id, :vendor_id, :repo_product_id, :status, :vouchers, :user_id, :user]

  field :code, 1, type: :string
  field :order_id, 2, type: :int32
  field :vendor_id, 3, type: :int32
  field :repo_product_id, 4, type: :int32
  field :status, 5, type: :int32
  field :vouchers, 6, type: :string
  field :user_id, 7, type: :int32
  field :user, 8, type: Common.UserInfo
end

defmodule Rancher.UpdateOrderPurchasePlanInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          order_id: integer,
          vendor_id: integer,
          repo_product_id: integer,
          status: integer,
          vouchers: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :code,
    :order_id,
    :vendor_id,
    :repo_product_id,
    :status,
    :vouchers,
    :user_id,
    :user,
    :id
  ]

  field :code, 1, type: :string
  field :order_id, 2, type: :int32
  field :vendor_id, 3, type: :int32
  field :repo_product_id, 4, type: :int32
  field :status, 5, type: :int32
  field :vouchers, 6, type: :string
  field :user_id, 7, type: :int32
  field :user, 8, type: Common.UserInfo
  field :id, 9, type: :int32
end

defmodule Rancher.OrderPurchasePlan do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          order_id: integer,
          vendor_id: integer,
          repo_product_id: integer,
          status: integer,
          vouchers: String.t(),
          user_id: integer,
          order: Rancher.Order.t() | nil,
          vendor: Rancher.Vendor.t() | nil,
          repo_product: Rancher.RepoProduct.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :order_id,
    :vendor_id,
    :repo_product_id,
    :status,
    :vouchers,
    :user_id,
    :order,
    :vendor,
    :repo_product,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :order_id, 3, type: :int32
  field :vendor_id, 4, type: :int32
  field :repo_product_id, 5, type: :int32
  field :status, 6, type: :int32
  field :vouchers, 7, type: :string
  field :user_id, 8, type: :int32
  field :order, 9, type: Rancher.Order
  field :vendor, 10, type: Rancher.Vendor
  field :repo_product, 11, type: Rancher.RepoProduct
  field :user, 12, type: Admin.User
  field :created_at, 13, type: :int32
  field :updated_at, 14, type: :int32
end

defmodule Rancher.OrderPurchasePlans do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_purchase_plans: [Rancher.OrderPurchasePlan.t()]
        }
  defstruct [:order_purchase_plans]

  field :order_purchase_plans, 1, repeated: true, type: Rancher.OrderPurchasePlan
end

defmodule Rancher.OrderPurchasePlanResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_purchase_plan: Rancher.OrderPurchasePlan.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:order_purchase_plan, :errors]

  field :order_purchase_plan, 1, type: Rancher.OrderPurchasePlan
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterRepoProductInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_id: String.t(),
          product_id: String.t(),
          room_id: String.t(),
          num: String.t(),
          remark: String.t(),
          addition_price: String.t(),
          addition_name: String.t(),
          length: String.t(),
          height: String.t(),
          user_id: String.t()
        }
  defstruct [
    :repo_id,
    :product_id,
    :room_id,
    :num,
    :remark,
    :addition_price,
    :addition_name,
    :length,
    :height,
    :user_id
  ]

  field :repo_id, 1, type: :string
  field :product_id, 2, type: :string
  field :room_id, 3, type: :string
  field :num, 4, type: :string
  field :remark, 5, type: :string
  field :addition_price, 6, type: :string
  field :addition_name, 7, type: :string
  field :length, 8, type: :string
  field :height, 9, type: :string
  field :user_id, 10, type: :string
end

defmodule Rancher.RepoProductsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterRepoProductInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          repo_ids: [integer],
          user_ids: [integer],
          product_ids: [integer],
          room_ids: [integer]
        }
  defstruct [
    :filter,
    :order,
    :paginate,
    :user,
    :ids,
    :repo_ids,
    :user_ids,
    :product_ids,
    :room_ids
  ]

  field :filter, 1, type: Rancher.FilterRepoProductInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :repo_ids, 6, repeated: true, type: :int32
  field :user_ids, 7, repeated: true, type: :int32
  field :product_ids, 8, repeated: true, type: :int32
  field :room_ids, 9, repeated: true, type: :int32
end

defmodule Rancher.CreateRepoProductInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_id: integer,
          product_id: integer,
          room_id: integer,
          num: integer,
          remark: String.t(),
          addition_price: String.t(),
          addition_name: String.t(),
          length: String.t(),
          height: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :repo_id,
    :product_id,
    :room_id,
    :num,
    :remark,
    :addition_price,
    :addition_name,
    :length,
    :height,
    :user_id,
    :user
  ]

  field :repo_id, 1, type: :int32
  field :product_id, 2, type: :int32
  field :room_id, 3, type: :int32
  field :num, 4, type: :int32
  field :remark, 5, type: :string
  field :addition_price, 6, type: :string
  field :addition_name, 7, type: :string
  field :length, 8, type: :string
  field :height, 9, type: :string
  field :user_id, 10, type: :int32
  field :user, 11, type: Common.UserInfo
end

defmodule Rancher.UpdateRepoProductInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_id: integer,
          product_id: integer,
          room_id: integer,
          num: integer,
          remark: String.t(),
          addition_price: String.t(),
          addition_name: String.t(),
          length: String.t(),
          height: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :repo_id,
    :product_id,
    :room_id,
    :num,
    :remark,
    :addition_price,
    :addition_name,
    :length,
    :height,
    :user_id,
    :user,
    :id
  ]

  field :repo_id, 1, type: :int32
  field :product_id, 2, type: :int32
  field :room_id, 3, type: :int32
  field :num, 4, type: :int32
  field :remark, 5, type: :string
  field :addition_price, 6, type: :string
  field :addition_name, 7, type: :string
  field :length, 8, type: :string
  field :height, 9, type: :string
  field :user_id, 10, type: :int32
  field :user, 11, type: Common.UserInfo
  field :id, 12, type: :int32
end

defmodule Rancher.RepoProduct do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          repo_id: integer,
          product_id: integer,
          room_id: integer,
          num: integer,
          remark: String.t(),
          addition_price: String.t(),
          addition_name: String.t(),
          length: String.t(),
          height: String.t(),
          user_id: integer,
          repo: Rancher.Repo.t() | nil,
          user: Admin.User.t() | nil,
          product: Rancher.Product.t() | nil,
          room: Rancher.Room.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :repo_id,
    :product_id,
    :room_id,
    :num,
    :remark,
    :addition_price,
    :addition_name,
    :length,
    :height,
    :user_id,
    :repo,
    :user,
    :product,
    :room,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :repo_id, 2, type: :int32
  field :product_id, 3, type: :int32
  field :room_id, 4, type: :int32
  field :num, 5, type: :int32
  field :remark, 6, type: :string
  field :addition_price, 7, type: :string
  field :addition_name, 8, type: :string
  field :length, 9, type: :string
  field :height, 10, type: :string
  field :user_id, 11, type: :int32
  field :repo, 12, type: Rancher.Repo
  field :user, 13, type: Admin.User
  field :product, 14, type: Rancher.Product
  field :room, 15, type: Rancher.Room
  field :created_at, 16, type: :int32
  field :updated_at, 17, type: :int32
end

defmodule Rancher.RepoProducts do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_products: [Rancher.RepoProduct.t()]
        }
  defstruct [:repo_products]

  field :repo_products, 1, repeated: true, type: Rancher.RepoProduct
end

defmodule Rancher.RepoProductResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_product: Rancher.RepoProduct.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:repo_product, :errors]

  field :repo_product, 1, type: Rancher.RepoProduct
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterRepoReviewAssignInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_review_id: String.t(),
          product_type_id: String.t(),
          user_id: String.t()
        }
  defstruct [:repo_review_id, :product_type_id, :user_id]

  field :repo_review_id, 1, type: :string
  field :product_type_id, 2, type: :string
  field :user_id, 3, type: :string
end

defmodule Rancher.RepoReviewAssignsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterRepoReviewAssignInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          repo_review_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :repo_review_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterRepoReviewAssignInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :repo_review_ids, 6, repeated: true, type: :int32
  field :user_ids, 7, repeated: true, type: :int32
end

defmodule Rancher.CreateRepoReviewAssignInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_review_id: integer,
          product_type_id: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:repo_review_id, :product_type_id, :user_id, :user]

  field :repo_review_id, 1, type: :int32
  field :product_type_id, 2, type: :int32
  field :user_id, 3, type: :int32
  field :user, 4, type: Common.UserInfo
end

defmodule Rancher.UpdateRepoReviewAssignInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_review_id: integer,
          product_type_id: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:repo_review_id, :product_type_id, :user_id, :user, :id]

  field :repo_review_id, 1, type: :int32
  field :product_type_id, 2, type: :int32
  field :user_id, 3, type: :int32
  field :user, 4, type: Common.UserInfo
  field :id, 5, type: :int32
end

defmodule Rancher.RepoReviewAssign do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          repo_review_id: integer,
          product_type_id: integer,
          user_id: integer,
          repo_review: Rancher.RepoReview.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :repo_review_id,
    :product_type_id,
    :user_id,
    :repo_review,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :repo_review_id, 2, type: :int32
  field :product_type_id, 3, type: :int32
  field :user_id, 4, type: :int32
  field :repo_review, 5, type: Rancher.RepoReview
  field :user, 6, type: Admin.User
  field :created_at, 7, type: :int32
  field :updated_at, 8, type: :int32
end

defmodule Rancher.RepoReviewAssigns do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_review_assigns: [Rancher.RepoReviewAssign.t()]
        }
  defstruct [:repo_review_assigns]

  field :repo_review_assigns, 1, repeated: true, type: Rancher.RepoReviewAssign
end

defmodule Rancher.RepoReviewAssignResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_review_assign: Rancher.RepoReviewAssign.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:repo_review_assign, :errors]

  field :repo_review_assign, 1, type: Rancher.RepoReviewAssign
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterCaseInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          spec: String.t(),
          price: String.t(),
          user_id: String.t()
        }
  defstruct [:code, :name, :spec, :price, :user_id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :spec, 3, type: :string
  field :price, 4, type: :string
  field :user_id, 5, type: :string
end

defmodule Rancher.CasesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterCaseInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :user_ids]

  field :filter, 1, type: Rancher.FilterCaseInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :user_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateCaseInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          spec: String.t(),
          price: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :name, :spec, :price, :user_id, :user]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :spec, 3, type: :string
  field :price, 4, type: :string
  field :user_id, 5, type: :int32
  field :user, 6, type: Common.UserInfo
end

defmodule Rancher.UpdateCaseInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          spec: String.t(),
          price: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :name, :spec, :price, :user_id, :user, :id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :spec, 3, type: :string
  field :price, 4, type: :string
  field :user_id, 5, type: :int32
  field :user, 6, type: Common.UserInfo
  field :id, 7, type: :int32
end

defmodule Rancher.Case do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          name: String.t(),
          spec: String.t(),
          price: String.t(),
          user_id: integer,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [:id, :code, :name, :spec, :price, :user_id, :user, :created_at, :updated_at]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :name, 3, type: :string
  field :spec, 4, type: :string
  field :price, 5, type: :string
  field :user_id, 6, type: :int32
  field :user, 7, type: Admin.User
  field :created_at, 8, type: :int32
  field :updated_at, 9, type: :int32
end

defmodule Rancher.Cases do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          cases: [Rancher.Case.t()]
        }
  defstruct [:cases]

  field :cases, 1, repeated: true, type: Rancher.Case
end

defmodule Rancher.CaseResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          case: Rancher.Case.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:case, :errors]

  field :case, 1, type: Rancher.Case
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterHouseInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          prompt_code: String.t(),
          spec_id: String.t(),
          address: String.t()
        }
  defstruct [:code, :prompt_code, :spec_id, :address]

  field :code, 1, type: :string
  field :prompt_code, 2, type: :string
  field :spec_id, 3, type: :string
  field :address, 4, type: :string
end

defmodule Rancher.HousesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterHouseInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          spec_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :spec_ids]

  field :filter, 1, type: Rancher.FilterHouseInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :spec_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateHouseInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          prompt_code: String.t(),
          spec_id: integer,
          address: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :prompt_code, :spec_id, :address, :user]

  field :code, 1, type: :string
  field :prompt_code, 2, type: :string
  field :spec_id, 3, type: :int32
  field :address, 4, type: :string
  field :user, 5, type: Common.UserInfo
end

defmodule Rancher.UpdateHouseInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          prompt_code: String.t(),
          spec_id: integer,
          address: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :prompt_code, :spec_id, :address, :user, :id]

  field :code, 1, type: :string
  field :prompt_code, 2, type: :string
  field :spec_id, 3, type: :int32
  field :address, 4, type: :string
  field :user, 5, type: Common.UserInfo
  field :id, 6, type: :int32
end

defmodule Rancher.House do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          prompt_code: String.t(),
          spec_id: integer,
          address: String.t(),
          spec: Rancher.Spec.t() | nil,
          customers: [Rancher.Customer.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :prompt_code,
    :spec_id,
    :address,
    :spec,
    :customers,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :prompt_code, 3, type: :string
  field :spec_id, 4, type: :int32
  field :address, 5, type: :string
  field :spec, 6, type: Rancher.Spec
  field :customers, 7, repeated: true, type: Rancher.Customer
  field :created_at, 8, type: :int32
  field :updated_at, 9, type: :int32
end

defmodule Rancher.Houses do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          houses: [Rancher.House.t()]
        }
  defstruct [:houses]

  field :houses, 1, repeated: true, type: Rancher.House
end

defmodule Rancher.HouseResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          house: Rancher.House.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:house, :errors]

  field :house, 1, type: Rancher.House
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterMessageInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sender_id: String.t(),
          content: String.t(),
          receiver_id: String.t(),
          is_read: String.t(),
          is_send: String.t()
        }
  defstruct [:sender_id, :content, :receiver_id, :is_read, :is_send]

  field :sender_id, 1, type: :string
  field :content, 2, type: :string
  field :receiver_id, 3, type: :string
  field :is_read, 4, type: :string
  field :is_send, 5, type: :string
end

defmodule Rancher.MessagesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterMessageInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          sender_ids: [integer],
          receiver_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :sender_ids, :receiver_ids]

  field :filter, 1, type: Rancher.FilterMessageInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :sender_ids, 6, repeated: true, type: :int32
  field :receiver_ids, 7, repeated: true, type: :int32
end

defmodule Rancher.CreateMessageInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sender_id: integer,
          content: String.t(),
          receiver_id: integer,
          is_read: boolean,
          is_send: boolean,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:sender_id, :content, :receiver_id, :is_read, :is_send, :user]

  field :sender_id, 1, type: :int32
  field :content, 2, type: :string
  field :receiver_id, 3, type: :int32
  field :is_read, 4, type: :bool
  field :is_send, 5, type: :bool
  field :user, 6, type: Common.UserInfo
end

defmodule Rancher.UpdateMessageInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sender_id: integer,
          content: String.t(),
          receiver_id: integer,
          is_read: boolean,
          is_send: boolean,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:sender_id, :content, :receiver_id, :is_read, :is_send, :user, :id]

  field :sender_id, 1, type: :int32
  field :content, 2, type: :string
  field :receiver_id, 3, type: :int32
  field :is_read, 4, type: :bool
  field :is_send, 5, type: :bool
  field :user, 6, type: Common.UserInfo
  field :id, 7, type: :int32
end

defmodule Rancher.Message do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          sender_id: integer,
          content: String.t(),
          receiver_id: integer,
          is_read: boolean,
          is_send: boolean,
          sender: Admin.User.t() | nil,
          receiver: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :sender_id,
    :content,
    :receiver_id,
    :is_read,
    :is_send,
    :sender,
    :receiver,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :sender_id, 2, type: :int32
  field :content, 3, type: :string
  field :receiver_id, 4, type: :int32
  field :is_read, 5, type: :bool
  field :is_send, 6, type: :bool
  field :sender, 7, type: Admin.User
  field :receiver, 8, type: Admin.User
  field :created_at, 9, type: :int32
  field :updated_at, 10, type: :int32
end

defmodule Rancher.Messages do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          messages: [Rancher.Message.t()]
        }
  defstruct [:messages]

  field :messages, 1, repeated: true, type: Rancher.Message
end

defmodule Rancher.MessageResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          message: Rancher.Message.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:message, :errors]

  field :message, 1, type: Rancher.Message
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterPaymentInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: String.t(),
          code: String.t(),
          pay_method: String.t(),
          vouchers: String.t(),
          remark: String.t(),
          user_id: String.t()
        }
  defstruct [:order_id, :code, :pay_method, :vouchers, :remark, :user_id]

  field :order_id, 1, type: :string
  field :code, 2, type: :string
  field :pay_method, 3, type: :string
  field :vouchers, 4, type: :string
  field :remark, 5, type: :string
  field :user_id, 6, type: :string
end

defmodule Rancher.PaymentsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterPaymentInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          user_ids: [integer],
          order_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :user_ids, :order_ids]

  field :filter, 1, type: Rancher.FilterPaymentInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :user_ids, 6, repeated: true, type: :int32
  field :order_ids, 7, repeated: true, type: :int32
end

defmodule Rancher.CreatePaymentInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: integer,
          code: String.t(),
          pay_method: integer,
          vouchers: String.t(),
          remark: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:order_id, :code, :pay_method, :vouchers, :remark, :user_id, :user]

  field :order_id, 1, type: :int32
  field :code, 2, type: :string
  field :pay_method, 3, type: :int32
  field :vouchers, 4, type: :string
  field :remark, 5, type: :string
  field :user_id, 6, type: :int32
  field :user, 7, type: Common.UserInfo
end

defmodule Rancher.UpdatePaymentInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: integer,
          code: String.t(),
          pay_method: integer,
          vouchers: String.t(),
          remark: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:order_id, :code, :pay_method, :vouchers, :remark, :user_id, :user, :id]

  field :order_id, 1, type: :int32
  field :code, 2, type: :string
  field :pay_method, 3, type: :int32
  field :vouchers, 4, type: :string
  field :remark, 5, type: :string
  field :user_id, 6, type: :int32
  field :user, 7, type: Common.UserInfo
  field :id, 8, type: :int32
end

defmodule Rancher.Payment do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          order_id: integer,
          code: String.t(),
          pay_method: integer,
          vouchers: String.t(),
          remark: String.t(),
          user_id: integer,
          user: Admin.User.t() | nil,
          order: Rancher.Order.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :order_id,
    :code,
    :pay_method,
    :vouchers,
    :remark,
    :user_id,
    :user,
    :order,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :order_id, 2, type: :int32
  field :code, 3, type: :string
  field :pay_method, 4, type: :int32
  field :vouchers, 5, type: :string
  field :remark, 6, type: :string
  field :user_id, 7, type: :int32
  field :user, 8, type: Admin.User
  field :order, 9, type: Rancher.Order
  field :created_at, 10, type: :int32
  field :updated_at, 11, type: :int32
end

defmodule Rancher.Payments do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          payments: [Rancher.Payment.t()]
        }
  defstruct [:payments]

  field :payments, 1, repeated: true, type: Rancher.Payment
end

defmodule Rancher.PaymentResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          payment: Rancher.Payment.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:payment, :errors]

  field :payment, 1, type: Rancher.Payment
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterProductInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          product_type_id: String.t(),
          name: String.t(),
          specification: String.t(),
          model_num: String.t(),
          calculate_method: String.t(),
          price: String.t(),
          images: String.t(),
          source: String.t(),
          user_id: String.t()
        }
  defstruct [
    :code,
    :product_type_id,
    :name,
    :specification,
    :model_num,
    :calculate_method,
    :price,
    :images,
    :source,
    :user_id
  ]

  field :code, 1, type: :string
  field :product_type_id, 2, type: :string
  field :name, 3, type: :string
  field :specification, 4, type: :string
  field :model_num, 5, type: :string
  field :calculate_method, 6, type: :string
  field :price, 7, type: :string
  field :images, 8, type: :string
  field :source, 9, type: :string
  field :user_id, 10, type: :string
end

defmodule Rancher.ProductsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterProductInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :user_ids]

  field :filter, 1, type: Rancher.FilterProductInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :user_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateProductInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          product_type_id: integer,
          name: String.t(),
          specification: String.t(),
          model_num: String.t(),
          calculate_method: integer,
          price: String.t(),
          images: String.t(),
          source: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :code,
    :product_type_id,
    :name,
    :specification,
    :model_num,
    :calculate_method,
    :price,
    :images,
    :source,
    :user_id,
    :user
  ]

  field :code, 1, type: :string
  field :product_type_id, 2, type: :int32
  field :name, 3, type: :string
  field :specification, 4, type: :string
  field :model_num, 5, type: :string
  field :calculate_method, 6, type: :int32
  field :price, 7, type: :string
  field :images, 8, type: :string
  field :source, 9, type: :string
  field :user_id, 10, type: :int32
  field :user, 11, type: Common.UserInfo
end

defmodule Rancher.UpdateProductInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          product_type_id: integer,
          name: String.t(),
          specification: String.t(),
          model_num: String.t(),
          calculate_method: integer,
          price: String.t(),
          images: String.t(),
          source: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :code,
    :product_type_id,
    :name,
    :specification,
    :model_num,
    :calculate_method,
    :price,
    :images,
    :source,
    :user_id,
    :user,
    :id
  ]

  field :code, 1, type: :string
  field :product_type_id, 2, type: :int32
  field :name, 3, type: :string
  field :specification, 4, type: :string
  field :model_num, 5, type: :string
  field :calculate_method, 6, type: :int32
  field :price, 7, type: :string
  field :images, 8, type: :string
  field :source, 9, type: :string
  field :user_id, 10, type: :int32
  field :user, 11, type: Common.UserInfo
  field :id, 12, type: :int32
end

defmodule Rancher.Product do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          product_type_id: integer,
          name: String.t(),
          specification: String.t(),
          model_num: String.t(),
          calculate_method: integer,
          price: String.t(),
          images: String.t(),
          source: String.t(),
          user_id: integer,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :product_type_id,
    :name,
    :specification,
    :model_num,
    :calculate_method,
    :price,
    :images,
    :source,
    :user_id,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :product_type_id, 3, type: :int32
  field :name, 4, type: :string
  field :specification, 5, type: :string
  field :model_num, 6, type: :string
  field :calculate_method, 7, type: :int32
  field :price, 8, type: :string
  field :images, 9, type: :string
  field :source, 10, type: :string
  field :user_id, 11, type: :int32
  field :user, 12, type: Admin.User
  field :created_at, 13, type: :int32
  field :updated_at, 14, type: :int32
end

defmodule Rancher.Products do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          products: [Rancher.Product.t()]
        }
  defstruct [:products]

  field :products, 1, repeated: true, type: Rancher.Product
end

defmodule Rancher.ProductResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          product: Rancher.Product.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:product, :errors]

  field :product, 1, type: Rancher.Product
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterCustomerInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          house_id: String.t(),
          name: String.t(),
          cellphone: String.t(),
          wechatid: String.t(),
          title: String.t(),
          age: String.t(),
          sex: String.t(),
          identity: String.t(),
          education: String.t(),
          income: String.t()
        }
  defstruct [
    :code,
    :house_id,
    :name,
    :cellphone,
    :wechatid,
    :title,
    :age,
    :sex,
    :identity,
    :education,
    :income
  ]

  field :code, 1, type: :string
  field :house_id, 2, type: :string
  field :name, 3, type: :string
  field :cellphone, 4, type: :string
  field :wechatid, 5, type: :string
  field :title, 6, type: :string
  field :age, 7, type: :string
  field :sex, 8, type: :string
  field :identity, 9, type: :string
  field :education, 10, type: :string
  field :income, 11, type: :string
end

defmodule Rancher.CustomersParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterCustomerInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          house_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :house_ids]

  field :filter, 1, type: Rancher.FilterCustomerInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :house_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateCustomerInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          house_id: integer,
          name: String.t(),
          cellphone: String.t(),
          wechatid: String.t(),
          title: String.t(),
          age: integer,
          sex: String.t(),
          identity: String.t(),
          education: String.t(),
          income: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :code,
    :house_id,
    :name,
    :cellphone,
    :wechatid,
    :title,
    :age,
    :sex,
    :identity,
    :education,
    :income,
    :user
  ]

  field :code, 1, type: :string
  field :house_id, 2, type: :int32
  field :name, 3, type: :string
  field :cellphone, 4, type: :string
  field :wechatid, 5, type: :string
  field :title, 6, type: :string
  field :age, 7, type: :int32
  field :sex, 8, type: :string
  field :identity, 9, type: :string
  field :education, 10, type: :string
  field :income, 11, type: :string
  field :user, 12, type: Common.UserInfo
end

defmodule Rancher.UpdateCustomerInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          house_id: integer,
          name: String.t(),
          cellphone: String.t(),
          wechatid: String.t(),
          title: String.t(),
          age: integer,
          sex: String.t(),
          identity: String.t(),
          education: String.t(),
          income: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :code,
    :house_id,
    :name,
    :cellphone,
    :wechatid,
    :title,
    :age,
    :sex,
    :identity,
    :education,
    :income,
    :user,
    :id
  ]

  field :code, 1, type: :string
  field :house_id, 2, type: :int32
  field :name, 3, type: :string
  field :cellphone, 4, type: :string
  field :wechatid, 5, type: :string
  field :title, 6, type: :string
  field :age, 7, type: :int32
  field :sex, 8, type: :string
  field :identity, 9, type: :string
  field :education, 10, type: :string
  field :income, 11, type: :string
  field :user, 12, type: Common.UserInfo
  field :id, 13, type: :int32
end

defmodule Rancher.Customer do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          house_id: integer,
          name: String.t(),
          cellphone: String.t(),
          wechatid: String.t(),
          title: String.t(),
          age: integer,
          sex: String.t(),
          identity: String.t(),
          education: String.t(),
          income: String.t(),
          house: Rancher.House.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :house_id,
    :name,
    :cellphone,
    :wechatid,
    :title,
    :age,
    :sex,
    :identity,
    :education,
    :income,
    :house,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :house_id, 3, type: :int32
  field :name, 4, type: :string
  field :cellphone, 5, type: :string
  field :wechatid, 6, type: :string
  field :title, 7, type: :string
  field :age, 8, type: :int32
  field :sex, 9, type: :string
  field :identity, 10, type: :string
  field :education, 11, type: :string
  field :income, 12, type: :string
  field :house, 13, type: Rancher.House
  field :created_at, 14, type: :int32
  field :updated_at, 15, type: :int32
end

defmodule Rancher.Customers do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          customers: [Rancher.Customer.t()]
        }
  defstruct [:customers]

  field :customers, 1, repeated: true, type: Rancher.Customer
end

defmodule Rancher.CustomerResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          customer: Rancher.Customer.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:customer, :errors]

  field :customer, 1, type: Rancher.Customer
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterOrderPlanInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: String.t(),
          repo_product_id: String.t(),
          vendor_id: String.t(),
          logistics: String.t(),
          logistics_code: String.t(),
          worker_name: String.t(),
          worker_cellphone: String.t(),
          plan_deal_date: String.t(),
          actual_deal_date: String.t(),
          plan_install_date: String.t(),
          actual_install_date: String.t(),
          is_notify_vendor: String.t(),
          is_notify_customer: String.t(),
          is_notify_worker: String.t(),
          user_id: String.t(),
          status: String.t()
        }
  defstruct [
    :order_id,
    :repo_product_id,
    :vendor_id,
    :logistics,
    :logistics_code,
    :worker_name,
    :worker_cellphone,
    :plan_deal_date,
    :actual_deal_date,
    :plan_install_date,
    :actual_install_date,
    :is_notify_vendor,
    :is_notify_customer,
    :is_notify_worker,
    :user_id,
    :status
  ]

  field :order_id, 1, type: :string
  field :repo_product_id, 2, type: :string
  field :vendor_id, 3, type: :string
  field :logistics, 4, type: :string
  field :logistics_code, 5, type: :string
  field :worker_name, 6, type: :string
  field :worker_cellphone, 7, type: :string
  field :plan_deal_date, 8, type: :string
  field :actual_deal_date, 9, type: :string
  field :plan_install_date, 10, type: :string
  field :actual_install_date, 11, type: :string
  field :is_notify_vendor, 12, type: :string
  field :is_notify_customer, 13, type: :string
  field :is_notify_worker, 14, type: :string
  field :user_id, 15, type: :string
  field :status, 16, type: :string
end

defmodule Rancher.OrderPlansParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterOrderPlanInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          order_ids: [integer],
          repo_product_ids: [integer],
          vendor_ids: [integer],
          user_ids: [integer]
        }
  defstruct [
    :filter,
    :order,
    :paginate,
    :user,
    :ids,
    :order_ids,
    :repo_product_ids,
    :vendor_ids,
    :user_ids
  ]

  field :filter, 1, type: Rancher.FilterOrderPlanInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :order_ids, 6, repeated: true, type: :int32
  field :repo_product_ids, 7, repeated: true, type: :int32
  field :vendor_ids, 8, repeated: true, type: :int32
  field :user_ids, 9, repeated: true, type: :int32
end

defmodule Rancher.CreateOrderPlanInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: integer,
          repo_product_id: integer,
          vendor_id: integer,
          logistics: String.t(),
          logistics_code: String.t(),
          worker_name: String.t(),
          worker_cellphone: String.t(),
          plan_deal_date: integer,
          actual_deal_date: integer,
          plan_install_date: integer,
          actual_install_date: integer,
          is_notify_vendor: integer,
          is_notify_customer: integer,
          is_notify_worker: integer,
          user_id: integer,
          status: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :order_id,
    :repo_product_id,
    :vendor_id,
    :logistics,
    :logistics_code,
    :worker_name,
    :worker_cellphone,
    :plan_deal_date,
    :actual_deal_date,
    :plan_install_date,
    :actual_install_date,
    :is_notify_vendor,
    :is_notify_customer,
    :is_notify_worker,
    :user_id,
    :status,
    :user
  ]

  field :order_id, 1, type: :int32
  field :repo_product_id, 2, type: :int32
  field :vendor_id, 3, type: :int32
  field :logistics, 4, type: :string
  field :logistics_code, 5, type: :string
  field :worker_name, 6, type: :string
  field :worker_cellphone, 7, type: :string
  field :plan_deal_date, 8, type: :int32
  field :actual_deal_date, 9, type: :int32
  field :plan_install_date, 10, type: :int32
  field :actual_install_date, 11, type: :int32
  field :is_notify_vendor, 12, type: :int32
  field :is_notify_customer, 13, type: :int32
  field :is_notify_worker, 14, type: :int32
  field :user_id, 15, type: :int32
  field :status, 16, type: :int32
  field :user, 17, type: Common.UserInfo
end

defmodule Rancher.UpdateOrderPlanInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: integer,
          repo_product_id: integer,
          vendor_id: integer,
          logistics: String.t(),
          logistics_code: String.t(),
          worker_name: String.t(),
          worker_cellphone: String.t(),
          plan_deal_date: integer,
          actual_deal_date: integer,
          plan_install_date: integer,
          actual_install_date: integer,
          is_notify_vendor: integer,
          is_notify_customer: integer,
          is_notify_worker: integer,
          user_id: integer,
          status: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :order_id,
    :repo_product_id,
    :vendor_id,
    :logistics,
    :logistics_code,
    :worker_name,
    :worker_cellphone,
    :plan_deal_date,
    :actual_deal_date,
    :plan_install_date,
    :actual_install_date,
    :is_notify_vendor,
    :is_notify_customer,
    :is_notify_worker,
    :user_id,
    :status,
    :user,
    :id
  ]

  field :order_id, 1, type: :int32
  field :repo_product_id, 2, type: :int32
  field :vendor_id, 3, type: :int32
  field :logistics, 4, type: :string
  field :logistics_code, 5, type: :string
  field :worker_name, 6, type: :string
  field :worker_cellphone, 7, type: :string
  field :plan_deal_date, 8, type: :int32
  field :actual_deal_date, 9, type: :int32
  field :plan_install_date, 10, type: :int32
  field :actual_install_date, 11, type: :int32
  field :is_notify_vendor, 12, type: :int32
  field :is_notify_customer, 13, type: :int32
  field :is_notify_worker, 14, type: :int32
  field :user_id, 15, type: :int32
  field :status, 16, type: :int32
  field :user, 17, type: Common.UserInfo
  field :id, 18, type: :int32
end

defmodule Rancher.OrderPlan do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          order_id: integer,
          repo_product_id: integer,
          vendor_id: integer,
          logistics: String.t(),
          logistics_code: String.t(),
          worker_name: String.t(),
          worker_cellphone: String.t(),
          plan_deal_date: integer,
          actual_deal_date: integer,
          plan_install_date: integer,
          actual_install_date: integer,
          is_notify_vendor: integer,
          is_notify_customer: integer,
          is_notify_worker: integer,
          user_id: integer,
          status: integer,
          order: Rancher.Order.t() | nil,
          repo_product: Rancher.RepoProduct.t() | nil,
          vendor: Rancher.Vendor.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :order_id,
    :repo_product_id,
    :vendor_id,
    :logistics,
    :logistics_code,
    :worker_name,
    :worker_cellphone,
    :plan_deal_date,
    :actual_deal_date,
    :plan_install_date,
    :actual_install_date,
    :is_notify_vendor,
    :is_notify_customer,
    :is_notify_worker,
    :user_id,
    :status,
    :order,
    :repo_product,
    :vendor,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :order_id, 2, type: :int32
  field :repo_product_id, 3, type: :int32
  field :vendor_id, 4, type: :int32
  field :logistics, 5, type: :string
  field :logistics_code, 6, type: :string
  field :worker_name, 7, type: :string
  field :worker_cellphone, 8, type: :string
  field :plan_deal_date, 9, type: :int32
  field :actual_deal_date, 10, type: :int32
  field :plan_install_date, 11, type: :int32
  field :actual_install_date, 12, type: :int32
  field :is_notify_vendor, 13, type: :int32
  field :is_notify_customer, 14, type: :int32
  field :is_notify_worker, 15, type: :int32
  field :user_id, 16, type: :int32
  field :status, 17, type: :int32
  field :order, 18, type: Rancher.Order
  field :repo_product, 19, type: Rancher.RepoProduct
  field :vendor, 20, type: Rancher.Vendor
  field :user, 21, type: Admin.User
  field :created_at, 22, type: :int32
  field :updated_at, 23, type: :int32
end

defmodule Rancher.OrderPlans do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_plans: [Rancher.OrderPlan.t()]
        }
  defstruct [:order_plans]

  field :order_plans, 1, repeated: true, type: Rancher.OrderPlan
end

defmodule Rancher.OrderPlanResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_plan: Rancher.OrderPlan.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:order_plan, :errors]

  field :order_plan, 1, type: Rancher.OrderPlan
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterBuildingInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          prompt_code: String.t(),
          name: String.t(),
          address: String.t(),
          lat: String.t(),
          lng: String.t(),
          user_id: String.t()
        }
  defstruct [:prompt_code, :name, :address, :lat, :lng, :user_id]

  field :prompt_code, 1, type: :string
  field :name, 2, type: :string
  field :address, 3, type: :string
  field :lat, 4, type: :string
  field :lng, 5, type: :string
  field :user_id, 6, type: :string
end

defmodule Rancher.BuildingsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterBuildingInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :user_ids]

  field :filter, 1, type: Rancher.FilterBuildingInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :user_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateBuildingInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          prompt_code: String.t(),
          name: String.t(),
          address: String.t(),
          lat: String.t(),
          lng: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:prompt_code, :name, :address, :lat, :lng, :user_id, :user]

  field :prompt_code, 1, type: :string
  field :name, 2, type: :string
  field :address, 3, type: :string
  field :lat, 4, type: :string
  field :lng, 5, type: :string
  field :user_id, 6, type: :int32
  field :user, 7, type: Common.UserInfo
end

defmodule Rancher.UpdateBuildingInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          prompt_code: String.t(),
          name: String.t(),
          address: String.t(),
          lat: String.t(),
          lng: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:prompt_code, :name, :address, :lat, :lng, :user_id, :user, :id]

  field :prompt_code, 1, type: :string
  field :name, 2, type: :string
  field :address, 3, type: :string
  field :lat, 4, type: :string
  field :lng, 5, type: :string
  field :user_id, 6, type: :int32
  field :user, 7, type: Common.UserInfo
  field :id, 8, type: :int32
end

defmodule Rancher.Building do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          prompt_code: String.t(),
          name: String.t(),
          address: String.t(),
          lat: String.t(),
          lng: String.t(),
          user_id: integer,
          user: Admin.User.t() | nil,
          specs: [Rancher.Spec.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :prompt_code,
    :name,
    :address,
    :lat,
    :lng,
    :user_id,
    :user,
    :specs,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :prompt_code, 2, type: :string
  field :name, 3, type: :string
  field :address, 4, type: :string
  field :lat, 5, type: :string
  field :lng, 6, type: :string
  field :user_id, 7, type: :int32
  field :user, 8, type: Admin.User
  field :specs, 9, repeated: true, type: Rancher.Spec
  field :created_at, 10, type: :int32
  field :updated_at, 11, type: :int32
end

defmodule Rancher.Buildings do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          buildings: [Rancher.Building.t()]
        }
  defstruct [:buildings]

  field :buildings, 1, repeated: true, type: Rancher.Building
end

defmodule Rancher.BuildingResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          building: Rancher.Building.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:building, :errors]

  field :building, 1, type: Rancher.Building
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterRepoReviewInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          reviewable_id: String.t(),
          reviewable_type: String.t(),
          user_id: String.t(),
          version: String.t()
        }
  defstruct [:code, :reviewable_id, :reviewable_type, :user_id, :version]

  field :code, 1, type: :string
  field :reviewable_id, 2, type: :string
  field :reviewable_type, 3, type: :string
  field :user_id, 4, type: :string
  field :version, 5, type: :string
end

defmodule Rancher.RepoReviewsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterRepoReviewInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids]

  field :filter, 1, type: Rancher.FilterRepoReviewInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
end

defmodule Rancher.CreateRepoReviewInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          reviewable_id: integer,
          reviewable_type: String.t(),
          user_id: integer,
          version: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :reviewable_id, :reviewable_type, :user_id, :version, :user]

  field :code, 1, type: :string
  field :reviewable_id, 2, type: :int32
  field :reviewable_type, 3, type: :string
  field :user_id, 4, type: :int32
  field :version, 5, type: :string
  field :user, 6, type: Common.UserInfo
end

defmodule Rancher.UpdateRepoReviewInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          reviewable_id: integer,
          reviewable_type: String.t(),
          user_id: integer,
          version: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :reviewable_id, :reviewable_type, :user_id, :version, :user, :id]

  field :code, 1, type: :string
  field :reviewable_id, 2, type: :int32
  field :reviewable_type, 3, type: :string
  field :user_id, 4, type: :int32
  field :version, 5, type: :string
  field :user, 6, type: Common.UserInfo
  field :id, 7, type: :int32
end

defmodule Rancher.RepoReview do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          reviewable_id: integer,
          reviewable_type: String.t(),
          user_id: integer,
          version: String.t(),
          repo_review_assigns: [Rancher.RepoReviewAssign.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :reviewable_id,
    :reviewable_type,
    :user_id,
    :version,
    :repo_review_assigns,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :reviewable_id, 3, type: :int32
  field :reviewable_type, 4, type: :string
  field :user_id, 5, type: :int32
  field :version, 6, type: :string
  field :repo_review_assigns, 7, repeated: true, type: Rancher.RepoReviewAssign
  field :created_at, 8, type: :int32
  field :updated_at, 9, type: :int32
end

defmodule Rancher.RepoReviews do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_reviews: [Rancher.RepoReview.t()]
        }
  defstruct [:repo_reviews]

  field :repo_reviews, 1, repeated: true, type: Rancher.RepoReview
end

defmodule Rancher.RepoReviewResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          repo_review: Rancher.RepoReview.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:repo_review, :errors]

  field :repo_review, 1, type: Rancher.RepoReview
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterStoryInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          ticket_id: String.t(),
          customer_id: String.t(),
          user_id: String.t(),
          remark: String.t()
        }
  defstruct [:ticket_id, :customer_id, :user_id, :remark]

  field :ticket_id, 1, type: :string
  field :customer_id, 2, type: :string
  field :user_id, 3, type: :string
  field :remark, 4, type: :string
end

defmodule Rancher.StoriesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterStoryInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          ticket_ids: [integer],
          customer_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :ticket_ids, :customer_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterStoryInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :ticket_ids, 6, repeated: true, type: :int32
  field :customer_ids, 7, repeated: true, type: :int32
  field :user_ids, 8, repeated: true, type: :int32
end

defmodule Rancher.CreateStoryInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          ticket_id: integer,
          customer_id: integer,
          user_id: integer,
          remark: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:ticket_id, :customer_id, :user_id, :remark, :user]

  field :ticket_id, 1, type: :int32
  field :customer_id, 2, type: :int32
  field :user_id, 3, type: :int32
  field :remark, 4, type: :string
  field :user, 5, type: Common.UserInfo
end

defmodule Rancher.UpdateStoryInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          ticket_id: integer,
          customer_id: integer,
          user_id: integer,
          remark: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:ticket_id, :customer_id, :user_id, :remark, :user, :id]

  field :ticket_id, 1, type: :int32
  field :customer_id, 2, type: :int32
  field :user_id, 3, type: :int32
  field :remark, 4, type: :string
  field :user, 5, type: Common.UserInfo
  field :id, 6, type: :int32
end

defmodule Rancher.Story do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          ticket_id: integer,
          customer_id: integer,
          user_id: integer,
          remark: String.t(),
          ticket: Rancher.Ticket.t() | nil,
          customer: Rancher.Customer.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :ticket_id,
    :customer_id,
    :user_id,
    :remark,
    :ticket,
    :customer,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :ticket_id, 2, type: :int32
  field :customer_id, 3, type: :int32
  field :user_id, 4, type: :int32
  field :remark, 5, type: :string
  field :ticket, 6, type: Rancher.Ticket
  field :customer, 7, type: Rancher.Customer
  field :user, 8, type: Admin.User
  field :created_at, 9, type: :int32
  field :updated_at, 10, type: :int32
end

defmodule Rancher.Stories do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          stories: [Rancher.Story.t()]
        }
  defstruct [:stories]

  field :stories, 1, repeated: true, type: Rancher.Story
end

defmodule Rancher.StoryResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          story: Rancher.Story.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:story, :errors]

  field :story, 1, type: Rancher.Story
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterTaskInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          targetable_id: String.t(),
          targetable_type: String.t(),
          status: String.t(),
          remark: String.t(),
          deadline_at: String.t(),
          user_id: String.t()
        }
  defstruct [:name, :targetable_id, :targetable_type, :status, :remark, :deadline_at, :user_id]

  field :name, 1, type: :string
  field :targetable_id, 2, type: :string
  field :targetable_type, 3, type: :string
  field :status, 4, type: :string
  field :remark, 5, type: :string
  field :deadline_at, 6, type: :string
  field :user_id, 7, type: :string
end

defmodule Rancher.TasksParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterTaskInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :user_ids]

  field :filter, 1, type: Rancher.FilterTaskInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :user_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateTaskInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          targetable_id: integer,
          targetable_type: String.t(),
          status: String.t(),
          remark: String.t(),
          deadline_at: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :name,
    :targetable_id,
    :targetable_type,
    :status,
    :remark,
    :deadline_at,
    :user_id,
    :user
  ]

  field :name, 1, type: :string
  field :targetable_id, 2, type: :int32
  field :targetable_type, 3, type: :string
  field :status, 4, type: :string
  field :remark, 5, type: :string
  field :deadline_at, 6, type: :int32
  field :user_id, 7, type: :int32
  field :user, 8, type: Common.UserInfo
end

defmodule Rancher.UpdateTaskInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          targetable_id: integer,
          targetable_type: String.t(),
          status: String.t(),
          remark: String.t(),
          deadline_at: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :name,
    :targetable_id,
    :targetable_type,
    :status,
    :remark,
    :deadline_at,
    :user_id,
    :user,
    :id
  ]

  field :name, 1, type: :string
  field :targetable_id, 2, type: :int32
  field :targetable_type, 3, type: :string
  field :status, 4, type: :string
  field :remark, 5, type: :string
  field :deadline_at, 6, type: :int32
  field :user_id, 7, type: :int32
  field :user, 8, type: Common.UserInfo
  field :id, 9, type: :int32
end

defmodule Rancher.Task do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          targetable_id: integer,
          targetable_type: String.t(),
          status: String.t(),
          remark: String.t(),
          deadline_at: integer,
          user_id: integer,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :name,
    :targetable_id,
    :targetable_type,
    :status,
    :remark,
    :deadline_at,
    :user_id,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :name, 2, type: :string
  field :targetable_id, 3, type: :int32
  field :targetable_type, 4, type: :string
  field :status, 5, type: :string
  field :remark, 6, type: :string
  field :deadline_at, 7, type: :int32
  field :user_id, 8, type: :int32
  field :user, 9, type: Admin.User
  field :created_at, 10, type: :int32
  field :updated_at, 11, type: :int32
end

defmodule Rancher.Tasks do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tasks: [Rancher.Task.t()]
        }
  defstruct [:tasks]

  field :tasks, 1, repeated: true, type: Rancher.Task
end

defmodule Rancher.TaskResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          task: Rancher.Task.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:task, :errors]

  field :task, 1, type: Rancher.Task
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterOrderSaleInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: String.t(),
          saled_type: String.t(),
          repo_product_id: String.t(),
          status: String.t(),
          remark: String.t(),
          expect_finish_date: String.t(),
          actual_finish_date: String.t(),
          vouchers: String.t(),
          user_id: String.t()
        }
  defstruct [
    :order_id,
    :saled_type,
    :repo_product_id,
    :status,
    :remark,
    :expect_finish_date,
    :actual_finish_date,
    :vouchers,
    :user_id
  ]

  field :order_id, 1, type: :string
  field :saled_type, 2, type: :string
  field :repo_product_id, 3, type: :string
  field :status, 4, type: :string
  field :remark, 5, type: :string
  field :expect_finish_date, 6, type: :string
  field :actual_finish_date, 7, type: :string
  field :vouchers, 8, type: :string
  field :user_id, 9, type: :string
end

defmodule Rancher.OrderSalesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterOrderSaleInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          order_ids: [integer],
          repo_product_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :order_ids, :repo_product_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterOrderSaleInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :order_ids, 6, repeated: true, type: :int32
  field :repo_product_ids, 7, repeated: true, type: :int32
  field :user_ids, 8, repeated: true, type: :int32
end

defmodule Rancher.CreateOrderSaleInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: integer,
          saled_type: integer,
          repo_product_id: integer,
          status: integer,
          remark: String.t(),
          expect_finish_date: integer,
          actual_finish_date: integer,
          vouchers: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :order_id,
    :saled_type,
    :repo_product_id,
    :status,
    :remark,
    :expect_finish_date,
    :actual_finish_date,
    :vouchers,
    :user_id,
    :user
  ]

  field :order_id, 1, type: :int32
  field :saled_type, 2, type: :int32
  field :repo_product_id, 3, type: :int32
  field :status, 4, type: :int32
  field :remark, 5, type: :string
  field :expect_finish_date, 6, type: :int32
  field :actual_finish_date, 7, type: :int32
  field :vouchers, 8, type: :string
  field :user_id, 9, type: :int32
  field :user, 10, type: Common.UserInfo
end

defmodule Rancher.UpdateOrderSaleInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: integer,
          saled_type: integer,
          repo_product_id: integer,
          status: integer,
          remark: String.t(),
          expect_finish_date: integer,
          actual_finish_date: integer,
          vouchers: String.t(),
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :order_id,
    :saled_type,
    :repo_product_id,
    :status,
    :remark,
    :expect_finish_date,
    :actual_finish_date,
    :vouchers,
    :user_id,
    :user,
    :id
  ]

  field :order_id, 1, type: :int32
  field :saled_type, 2, type: :int32
  field :repo_product_id, 3, type: :int32
  field :status, 4, type: :int32
  field :remark, 5, type: :string
  field :expect_finish_date, 6, type: :int32
  field :actual_finish_date, 7, type: :int32
  field :vouchers, 8, type: :string
  field :user_id, 9, type: :int32
  field :user, 10, type: Common.UserInfo
  field :id, 11, type: :int32
end

defmodule Rancher.OrderSale do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          order_id: integer,
          saled_type: integer,
          repo_product_id: integer,
          status: integer,
          remark: String.t(),
          expect_finish_date: integer,
          actual_finish_date: integer,
          vouchers: String.t(),
          user_id: integer,
          order: Rancher.Order.t() | nil,
          repo_product: Rancher.RepoProduct.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :order_id,
    :saled_type,
    :repo_product_id,
    :status,
    :remark,
    :expect_finish_date,
    :actual_finish_date,
    :vouchers,
    :user_id,
    :order,
    :repo_product,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :order_id, 2, type: :int32
  field :saled_type, 3, type: :int32
  field :repo_product_id, 4, type: :int32
  field :status, 5, type: :int32
  field :remark, 6, type: :string
  field :expect_finish_date, 7, type: :int32
  field :actual_finish_date, 8, type: :int32
  field :vouchers, 9, type: :string
  field :user_id, 10, type: :int32
  field :order, 11, type: Rancher.Order
  field :repo_product, 12, type: Rancher.RepoProduct
  field :user, 13, type: Admin.User
  field :created_at, 14, type: :int32
  field :updated_at, 15, type: :int32
end

defmodule Rancher.OrderSales do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_sales: [Rancher.OrderSale.t()]
        }
  defstruct [:order_sales]

  field :order_sales, 1, repeated: true, type: Rancher.OrderSale
end

defmodule Rancher.OrderSaleResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_sale: Rancher.OrderSale.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:order_sale, :errors]

  field :order_sale, 1, type: Rancher.OrderSale
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterProductTypeInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t()
        }
  defstruct [:code, :name]

  field :code, 1, type: :string
  field :name, 2, type: :string
end

defmodule Rancher.ProductTypesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterProductTypeInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids]

  field :filter, 1, type: Rancher.FilterProductTypeInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
end

defmodule Rancher.CreateProductTypeInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :name, :user]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :user, 3, type: Common.UserInfo
end

defmodule Rancher.UpdateProductTypeInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :name, :user, :id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :user, 3, type: Common.UserInfo
  field :id, 4, type: :int32
end

defmodule Rancher.ProductType do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          name: String.t(),
          created_at: integer,
          updated_at: integer
        }
  defstruct [:id, :code, :name, :created_at, :updated_at]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :name, 3, type: :string
  field :created_at, 4, type: :int32
  field :updated_at, 5, type: :int32
end

defmodule Rancher.ProductTypes do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          product_types: [Rancher.ProductType.t()]
        }
  defstruct [:product_types]

  field :product_types, 1, repeated: true, type: Rancher.ProductType
end

defmodule Rancher.ProductTypeResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          product_type: Rancher.ProductType.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:product_type, :errors]

  field :product_type, 1, type: Rancher.ProductType
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterSpecInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          building_id: String.t(),
          name: String.t(),
          rough: String.t(),
          precise: String.t(),
          area: String.t(),
          user_id: String.t()
        }
  defstruct [:building_id, :name, :rough, :precise, :area, :user_id]

  field :building_id, 1, type: :string
  field :name, 2, type: :string
  field :rough, 3, type: :string
  field :precise, 4, type: :string
  field :area, 5, type: :string
  field :user_id, 6, type: :string
end

defmodule Rancher.SpecsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterSpecInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          user_ids: [integer],
          building_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :user_ids, :building_ids]

  field :filter, 1, type: Rancher.FilterSpecInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :user_ids, 6, repeated: true, type: :int32
  field :building_ids, 7, repeated: true, type: :int32
end

defmodule Rancher.CreateSpecInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          building_id: integer,
          name: String.t(),
          rough: String.t(),
          precise: String.t(),
          area: float | :infinity | :negative_infinity | :nan,
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:building_id, :name, :rough, :precise, :area, :user_id, :user]

  field :building_id, 1, type: :int32
  field :name, 2, type: :string
  field :rough, 3, type: :string
  field :precise, 4, type: :string
  field :area, 5, type: :float
  field :user_id, 6, type: :int32
  field :user, 7, type: Common.UserInfo
end

defmodule Rancher.UpdateSpecInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          building_id: integer,
          name: String.t(),
          rough: String.t(),
          precise: String.t(),
          area: float | :infinity | :negative_infinity | :nan,
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:building_id, :name, :rough, :precise, :area, :user_id, :user, :id]

  field :building_id, 1, type: :int32
  field :name, 2, type: :string
  field :rough, 3, type: :string
  field :precise, 4, type: :string
  field :area, 5, type: :float
  field :user_id, 6, type: :int32
  field :user, 7, type: Common.UserInfo
  field :id, 8, type: :int32
end

defmodule Rancher.Spec do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          building_id: integer,
          name: String.t(),
          rough: String.t(),
          precise: String.t(),
          area: float | :infinity | :negative_infinity | :nan,
          user_id: integer,
          user: Admin.User.t() | nil,
          building: Rancher.Building.t() | nil,
          quotes: [Rancher.Quote.t()],
          rooms: [Rancher.Room.t()],
          houses: [Rancher.House.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :building_id,
    :name,
    :rough,
    :precise,
    :area,
    :user_id,
    :user,
    :building,
    :quotes,
    :rooms,
    :houses,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :building_id, 2, type: :int32
  field :name, 3, type: :string
  field :rough, 4, type: :string
  field :precise, 5, type: :string
  field :area, 6, type: :float
  field :user_id, 7, type: :int32
  field :user, 8, type: Admin.User
  field :building, 9, type: Rancher.Building
  field :quotes, 10, repeated: true, type: Rancher.Quote
  field :rooms, 11, repeated: true, type: Rancher.Room
  field :houses, 12, repeated: true, type: Rancher.House
  field :created_at, 13, type: :int32
  field :updated_at, 14, type: :int32
end

defmodule Rancher.Specs do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          specs: [Rancher.Spec.t()]
        }
  defstruct [:specs]

  field :specs, 1, repeated: true, type: Rancher.Spec
end

defmodule Rancher.SpecResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          spec: Rancher.Spec.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:spec, :errors]

  field :spec, 1, type: Rancher.Spec
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterVendorInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          prompt_code: String.t(),
          name: String.t(),
          address: String.t(),
          contact: String.t(),
          cellphone: String.t()
        }
  defstruct [:code, :prompt_code, :name, :address, :contact, :cellphone]

  field :code, 1, type: :string
  field :prompt_code, 2, type: :string
  field :name, 3, type: :string
  field :address, 4, type: :string
  field :contact, 5, type: :string
  field :cellphone, 6, type: :string
end

defmodule Rancher.VendorsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterVendorInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids]

  field :filter, 1, type: Rancher.FilterVendorInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
end

defmodule Rancher.CreateVendorInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          prompt_code: String.t(),
          name: String.t(),
          address: String.t(),
          contact: String.t(),
          cellphone: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :prompt_code, :name, :address, :contact, :cellphone, :user]

  field :code, 1, type: :string
  field :prompt_code, 2, type: :string
  field :name, 3, type: :string
  field :address, 4, type: :string
  field :contact, 5, type: :string
  field :cellphone, 6, type: :string
  field :user, 7, type: Common.UserInfo
end

defmodule Rancher.UpdateVendorInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          prompt_code: String.t(),
          name: String.t(),
          address: String.t(),
          contact: String.t(),
          cellphone: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :prompt_code, :name, :address, :contact, :cellphone, :user, :id]

  field :code, 1, type: :string
  field :prompt_code, 2, type: :string
  field :name, 3, type: :string
  field :address, 4, type: :string
  field :contact, 5, type: :string
  field :cellphone, 6, type: :string
  field :user, 7, type: Common.UserInfo
  field :id, 8, type: :int32
end

defmodule Rancher.Vendor do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          prompt_code: String.t(),
          name: String.t(),
          address: String.t(),
          contact: String.t(),
          cellphone: String.t(),
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :prompt_code,
    :name,
    :address,
    :contact,
    :cellphone,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :prompt_code, 3, type: :string
  field :name, 4, type: :string
  field :address, 5, type: :string
  field :contact, 6, type: :string
  field :cellphone, 7, type: :string
  field :created_at, 8, type: :int32
  field :updated_at, 9, type: :int32
end

defmodule Rancher.Vendors do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          vendors: [Rancher.Vendor.t()]
        }
  defstruct [:vendors]

  field :vendors, 1, repeated: true, type: Rancher.Vendor
end

defmodule Rancher.VendorResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          vendor: Rancher.Vendor.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:vendor, :errors]

  field :vendor, 1, type: Rancher.Vendor
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterVendorScoreInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          vendor_id: String.t(),
          vendor_dimension_id: String.t(),
          score: String.t(),
          user_id: String.t()
        }
  defstruct [:vendor_id, :vendor_dimension_id, :score, :user_id]

  field :vendor_id, 1, type: :string
  field :vendor_dimension_id, 2, type: :string
  field :score, 3, type: :string
  field :user_id, 4, type: :string
end

defmodule Rancher.VendorScoresParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterVendorScoreInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          vendor_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :vendor_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterVendorScoreInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :vendor_ids, 6, repeated: true, type: :int32
  field :user_ids, 7, repeated: true, type: :int32
end

defmodule Rancher.CreateVendorScoreInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          vendor_id: integer,
          vendor_dimension_id: integer,
          score: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:vendor_id, :vendor_dimension_id, :score, :user_id, :user]

  field :vendor_id, 1, type: :int32
  field :vendor_dimension_id, 2, type: :int32
  field :score, 3, type: :int32
  field :user_id, 4, type: :int32
  field :user, 5, type: Common.UserInfo
end

defmodule Rancher.UpdateVendorScoreInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          vendor_id: integer,
          vendor_dimension_id: integer,
          score: integer,
          user_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:vendor_id, :vendor_dimension_id, :score, :user_id, :user, :id]

  field :vendor_id, 1, type: :int32
  field :vendor_dimension_id, 2, type: :int32
  field :score, 3, type: :int32
  field :user_id, 4, type: :int32
  field :user, 5, type: Common.UserInfo
  field :id, 6, type: :int32
end

defmodule Rancher.VendorScore do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          vendor_id: integer,
          vendor_dimension_id: integer,
          score: integer,
          user_id: integer,
          vendor: Rancher.Vendor.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :vendor_id,
    :vendor_dimension_id,
    :score,
    :user_id,
    :vendor,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :vendor_id, 2, type: :int32
  field :vendor_dimension_id, 3, type: :int32
  field :score, 4, type: :int32
  field :user_id, 5, type: :int32
  field :vendor, 6, type: Rancher.Vendor
  field :user, 7, type: Admin.User
  field :created_at, 8, type: :int32
  field :updated_at, 9, type: :int32
end

defmodule Rancher.VendorScores do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          vendor_scores: [Rancher.VendorScore.t()]
        }
  defstruct [:vendor_scores]

  field :vendor_scores, 1, repeated: true, type: Rancher.VendorScore
end

defmodule Rancher.VendorScoreResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          vendor_score: Rancher.VendorScore.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:vendor_score, :errors]

  field :vendor_score, 1, type: Rancher.VendorScore
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterVendorDimensionInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t()
        }
  defstruct [:code, :name]

  field :code, 1, type: :string
  field :name, 2, type: :string
end

defmodule Rancher.VendorDimensionsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterVendorDimensionInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids]

  field :filter, 1, type: Rancher.FilterVendorDimensionInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
end

defmodule Rancher.CreateVendorDimensionInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :name, :user]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :user, 3, type: Common.UserInfo
end

defmodule Rancher.UpdateVendorDimensionInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :name, :user, :id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :user, 3, type: Common.UserInfo
  field :id, 4, type: :int32
end

defmodule Rancher.VendorDimension do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          name: String.t(),
          created_at: integer,
          updated_at: integer
        }
  defstruct [:id, :code, :name, :created_at, :updated_at]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :name, 3, type: :string
  field :created_at, 4, type: :int32
  field :updated_at, 5, type: :int32
end

defmodule Rancher.VendorDimensions do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          vendor_dimensions: [Rancher.VendorDimension.t()]
        }
  defstruct [:vendor_dimensions]

  field :vendor_dimensions, 1, repeated: true, type: Rancher.VendorDimension
end

defmodule Rancher.VendorDimensionResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          vendor_dimension: Rancher.VendorDimension.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:vendor_dimension, :errors]

  field :vendor_dimension, 1, type: Rancher.VendorDimension
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterWorkFlowApplyInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_id: String.t(),
          user_id: String.t(),
          cur_node_id: String.t(),
          status: String.t(),
          priority: String.t()
        }
  defstruct [:work_flow_id, :user_id, :cur_node_id, :status, :priority]

  field :work_flow_id, 1, type: :string
  field :user_id, 2, type: :string
  field :cur_node_id, 3, type: :string
  field :status, 4, type: :string
  field :priority, 5, type: :string
end

defmodule Rancher.WorkFlowAppliesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterWorkFlowApplyInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          work_flow_ids: [integer],
          user_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :work_flow_ids, :user_ids]

  field :filter, 1, type: Rancher.FilterWorkFlowApplyInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :work_flow_ids, 6, repeated: true, type: :int32
  field :user_ids, 7, repeated: true, type: :int32
end

defmodule Rancher.CreateWorkFlowApplyInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_id: integer,
          user_id: integer,
          cur_node_id: integer,
          status: integer,
          priority: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:work_flow_id, :user_id, :cur_node_id, :status, :priority, :user]

  field :work_flow_id, 1, type: :int32
  field :user_id, 2, type: :int32
  field :cur_node_id, 3, type: :int32
  field :status, 4, type: :int32
  field :priority, 5, type: :int32
  field :user, 6, type: Common.UserInfo
end

defmodule Rancher.UpdateWorkFlowApplyInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_id: integer,
          user_id: integer,
          cur_node_id: integer,
          status: integer,
          priority: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:work_flow_id, :user_id, :cur_node_id, :status, :priority, :user, :id]

  field :work_flow_id, 1, type: :int32
  field :user_id, 2, type: :int32
  field :cur_node_id, 3, type: :int32
  field :status, 4, type: :int32
  field :priority, 5, type: :int32
  field :user, 6, type: Common.UserInfo
  field :id, 7, type: :int32
end

defmodule Rancher.WorkFlowApply do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          work_flow_id: integer,
          user_id: integer,
          cur_node_id: integer,
          status: integer,
          priority: integer,
          work_flow: Rancher.WorkFlow.t() | nil,
          user: Admin.User.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :work_flow_id,
    :user_id,
    :cur_node_id,
    :status,
    :priority,
    :work_flow,
    :user,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :work_flow_id, 2, type: :int32
  field :user_id, 3, type: :int32
  field :cur_node_id, 4, type: :int32
  field :status, 5, type: :int32
  field :priority, 6, type: :int32
  field :work_flow, 7, type: Rancher.WorkFlow
  field :user, 8, type: Admin.User
  field :created_at, 9, type: :int32
  field :updated_at, 10, type: :int32
end

defmodule Rancher.WorkFlowApplies do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_applies: [Rancher.WorkFlowApply.t()]
        }
  defstruct [:work_flow_applies]

  field :work_flow_applies, 1, repeated: true, type: Rancher.WorkFlowApply
end

defmodule Rancher.WorkFlowApplyResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_apply: Rancher.WorkFlowApply.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:work_flow_apply, :errors]

  field :work_flow_apply, 1, type: Rancher.WorkFlowApply
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterWorkFlowNodeBranchInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_node_id: String.t(),
          name: String.t()
        }
  defstruct [:work_flow_node_id, :name]

  field :work_flow_node_id, 1, type: :string
  field :name, 2, type: :string
end

defmodule Rancher.WorkFlowNodeBranchesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterWorkFlowNodeBranchInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          work_flow_node_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :work_flow_node_ids]

  field :filter, 1, type: Rancher.FilterWorkFlowNodeBranchInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :work_flow_node_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateWorkFlowNodeBranchInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_node_id: integer,
          name: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:work_flow_node_id, :name, :user]

  field :work_flow_node_id, 1, type: :int32
  field :name, 2, type: :string
  field :user, 3, type: Common.UserInfo
end

defmodule Rancher.UpdateWorkFlowNodeBranchInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_node_id: integer,
          name: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:work_flow_node_id, :name, :user, :id]

  field :work_flow_node_id, 1, type: :int32
  field :name, 2, type: :string
  field :user, 3, type: Common.UserInfo
  field :id, 4, type: :int32
end

defmodule Rancher.WorkFlowNodeBranch do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          work_flow_node_id: integer,
          name: String.t(),
          work_flow_node: Rancher.WorkFlowNode.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [:id, :work_flow_node_id, :name, :work_flow_node, :created_at, :updated_at]

  field :id, 1, type: :int32
  field :work_flow_node_id, 2, type: :int32
  field :name, 3, type: :string
  field :work_flow_node, 4, type: Rancher.WorkFlowNode
  field :created_at, 5, type: :int32
  field :updated_at, 6, type: :int32
end

defmodule Rancher.WorkFlowNodeBranches do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_node_branches: [Rancher.WorkFlowNodeBranch.t()]
        }
  defstruct [:work_flow_node_branches]

  field :work_flow_node_branches, 1, repeated: true, type: Rancher.WorkFlowNodeBranch
end

defmodule Rancher.WorkFlowNodeBranchResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_node_branch: Rancher.WorkFlowNodeBranch.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:work_flow_node_branch, :errors]

  field :work_flow_node_branch, 1, type: Rancher.WorkFlowNodeBranch
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterWorkFlowNodeInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_id: String.t(),
          name: String.t(),
          prev_node_id: String.t(),
          next_node_id: String.t(),
          failed_transition_node_id: String.t(),
          node_type: String.t(),
          node_func_type: String.t(),
          node_func_class_name: String.t(),
          order: String.t(),
          has_branches: String.t()
        }
  defstruct [
    :work_flow_id,
    :name,
    :prev_node_id,
    :next_node_id,
    :failed_transition_node_id,
    :node_type,
    :node_func_type,
    :node_func_class_name,
    :order,
    :has_branches
  ]

  field :work_flow_id, 1, type: :string
  field :name, 2, type: :string
  field :prev_node_id, 3, type: :string
  field :next_node_id, 4, type: :string
  field :failed_transition_node_id, 5, type: :string
  field :node_type, 6, type: :string
  field :node_func_type, 7, type: :string
  field :node_func_class_name, 8, type: :string
  field :order, 9, type: :string
  field :has_branches, 10, type: :string
end

defmodule Rancher.WorkFlowNodesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterWorkFlowNodeInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          work_flow_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :work_flow_ids]

  field :filter, 1, type: Rancher.FilterWorkFlowNodeInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :work_flow_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateWorkFlowNodeInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_id: integer,
          name: String.t(),
          prev_node_id: integer,
          next_node_id: integer,
          failed_transition_node_id: integer,
          node_type: integer,
          node_func_type: integer,
          node_func_class_name: String.t(),
          order: integer,
          has_branches: boolean,
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :work_flow_id,
    :name,
    :prev_node_id,
    :next_node_id,
    :failed_transition_node_id,
    :node_type,
    :node_func_type,
    :node_func_class_name,
    :order,
    :has_branches,
    :user
  ]

  field :work_flow_id, 1, type: :int32
  field :name, 2, type: :string
  field :prev_node_id, 3, type: :int32
  field :next_node_id, 4, type: :int32
  field :failed_transition_node_id, 5, type: :int32
  field :node_type, 6, type: :int32
  field :node_func_type, 7, type: :int32
  field :node_func_class_name, 8, type: :string
  field :order, 9, type: :int32
  field :has_branches, 10, type: :bool
  field :user, 11, type: Common.UserInfo
end

defmodule Rancher.UpdateWorkFlowNodeInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_id: integer,
          name: String.t(),
          prev_node_id: integer,
          next_node_id: integer,
          failed_transition_node_id: integer,
          node_type: integer,
          node_func_type: integer,
          node_func_class_name: String.t(),
          order: integer,
          has_branches: boolean,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :work_flow_id,
    :name,
    :prev_node_id,
    :next_node_id,
    :failed_transition_node_id,
    :node_type,
    :node_func_type,
    :node_func_class_name,
    :order,
    :has_branches,
    :user,
    :id
  ]

  field :work_flow_id, 1, type: :int32
  field :name, 2, type: :string
  field :prev_node_id, 3, type: :int32
  field :next_node_id, 4, type: :int32
  field :failed_transition_node_id, 5, type: :int32
  field :node_type, 6, type: :int32
  field :node_func_type, 7, type: :int32
  field :node_func_class_name, 8, type: :string
  field :order, 9, type: :int32
  field :has_branches, 10, type: :bool
  field :user, 11, type: Common.UserInfo
  field :id, 12, type: :int32
end

defmodule Rancher.WorkFlowNode do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          work_flow_id: integer,
          name: String.t(),
          prev_node_id: integer,
          next_node_id: integer,
          failed_transition_node_id: integer,
          node_type: integer,
          node_func_type: integer,
          node_func_class_name: String.t(),
          order: integer,
          has_branches: boolean,
          work_flow: Rancher.WorkFlow.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :work_flow_id,
    :name,
    :prev_node_id,
    :next_node_id,
    :failed_transition_node_id,
    :node_type,
    :node_func_type,
    :node_func_class_name,
    :order,
    :has_branches,
    :work_flow,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :work_flow_id, 2, type: :int32
  field :name, 3, type: :string
  field :prev_node_id, 4, type: :int32
  field :next_node_id, 5, type: :int32
  field :failed_transition_node_id, 6, type: :int32
  field :node_type, 7, type: :int32
  field :node_func_type, 8, type: :int32
  field :node_func_class_name, 9, type: :string
  field :order, 10, type: :int32
  field :has_branches, 11, type: :bool
  field :work_flow, 12, type: Rancher.WorkFlow
  field :created_at, 13, type: :int32
  field :updated_at, 14, type: :int32
end

defmodule Rancher.WorkFlowNodes do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_nodes: [Rancher.WorkFlowNode.t()]
        }
  defstruct [:work_flow_nodes]

  field :work_flow_nodes, 1, repeated: true, type: Rancher.WorkFlowNode
end

defmodule Rancher.WorkFlowNodeResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_node: Rancher.WorkFlowNode.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:work_flow_node, :errors]

  field :work_flow_node, 1, type: Rancher.WorkFlowNode
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterWorkFlowProcessInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_apply_id: String.t(),
          work_flow_node_id: String.t(),
          work_flow_node_branch_id: String.t(),
          operation: String.t(),
          reason: String.t()
        }
  defstruct [
    :work_flow_apply_id,
    :work_flow_node_id,
    :work_flow_node_branch_id,
    :operation,
    :reason
  ]

  field :work_flow_apply_id, 1, type: :string
  field :work_flow_node_id, 2, type: :string
  field :work_flow_node_branch_id, 3, type: :string
  field :operation, 4, type: :string
  field :reason, 5, type: :string
end

defmodule Rancher.WorkFlowProcessesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterWorkFlowProcessInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          work_flow_apply_ids: [integer],
          work_flow_node_ids: [integer],
          work_flow_node_branch_ids: [integer]
        }
  defstruct [
    :filter,
    :order,
    :paginate,
    :user,
    :ids,
    :work_flow_apply_ids,
    :work_flow_node_ids,
    :work_flow_node_branch_ids
  ]

  field :filter, 1, type: Rancher.FilterWorkFlowProcessInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :work_flow_apply_ids, 6, repeated: true, type: :int32
  field :work_flow_node_ids, 7, repeated: true, type: :int32
  field :work_flow_node_branch_ids, 8, repeated: true, type: :int32
end

defmodule Rancher.CreateWorkFlowProcessInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_apply_id: integer,
          work_flow_node_id: integer,
          work_flow_node_branch_id: integer,
          operation: integer,
          reason: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :work_flow_apply_id,
    :work_flow_node_id,
    :work_flow_node_branch_id,
    :operation,
    :reason,
    :user
  ]

  field :work_flow_apply_id, 1, type: :int32
  field :work_flow_node_id, 2, type: :int32
  field :work_flow_node_branch_id, 3, type: :int32
  field :operation, 4, type: :int32
  field :reason, 5, type: :string
  field :user, 6, type: Common.UserInfo
end

defmodule Rancher.UpdateWorkFlowProcessInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_apply_id: integer,
          work_flow_node_id: integer,
          work_flow_node_branch_id: integer,
          operation: integer,
          reason: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :work_flow_apply_id,
    :work_flow_node_id,
    :work_flow_node_branch_id,
    :operation,
    :reason,
    :user,
    :id
  ]

  field :work_flow_apply_id, 1, type: :int32
  field :work_flow_node_id, 2, type: :int32
  field :work_flow_node_branch_id, 3, type: :int32
  field :operation, 4, type: :int32
  field :reason, 5, type: :string
  field :user, 6, type: Common.UserInfo
  field :id, 7, type: :int32
end

defmodule Rancher.WorkFlowProcess do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          work_flow_apply_id: integer,
          work_flow_node_id: integer,
          work_flow_node_branch_id: integer,
          operation: integer,
          reason: String.t(),
          work_flow_apply: Rancher.WorkFlowApply.t() | nil,
          work_flow_node: Rancher.WorkFlowNode.t() | nil,
          work_flow_node_branch: Rancher.WorkFlowNodeBranch.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :work_flow_apply_id,
    :work_flow_node_id,
    :work_flow_node_branch_id,
    :operation,
    :reason,
    :work_flow_apply,
    :work_flow_node,
    :work_flow_node_branch,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :work_flow_apply_id, 2, type: :int32
  field :work_flow_node_id, 3, type: :int32
  field :work_flow_node_branch_id, 4, type: :int32
  field :operation, 5, type: :int32
  field :reason, 6, type: :string
  field :work_flow_apply, 7, type: Rancher.WorkFlowApply
  field :work_flow_node, 8, type: Rancher.WorkFlowNode
  field :work_flow_node_branch, 9, type: Rancher.WorkFlowNodeBranch
  field :created_at, 10, type: :int32
  field :updated_at, 11, type: :int32
end

defmodule Rancher.WorkFlowProcesses do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_processes: [Rancher.WorkFlowProcess.t()]
        }
  defstruct [:work_flow_processes]

  field :work_flow_processes, 1, repeated: true, type: Rancher.WorkFlowProcess
end

defmodule Rancher.WorkFlowProcessResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow_process: Rancher.WorkFlowProcess.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:work_flow_process, :errors]

  field :work_flow_process, 1, type: Rancher.WorkFlowProcess
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterWorkFlowInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          workable_id: String.t(),
          workable_type: String.t(),
          remark: String.t()
        }
  defstruct [:code, :name, :workable_id, :workable_type, :remark]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :workable_id, 3, type: :string
  field :workable_type, 4, type: :string
  field :remark, 5, type: :string
end

defmodule Rancher.WorkFlowsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterWorkFlowInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids]

  field :filter, 1, type: Rancher.FilterWorkFlowInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
end

defmodule Rancher.CreateWorkFlowInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          workable_id: integer,
          workable_type: String.t(),
          remark: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :name, :workable_id, :workable_type, :remark, :user]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :workable_id, 3, type: :int32
  field :workable_type, 4, type: :string
  field :remark, 5, type: :string
  field :user, 6, type: Common.UserInfo
end

defmodule Rancher.UpdateWorkFlowInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          workable_id: integer,
          workable_type: String.t(),
          remark: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :name, :workable_id, :workable_type, :remark, :user, :id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :workable_id, 3, type: :int32
  field :workable_type, 4, type: :string
  field :remark, 5, type: :string
  field :user, 6, type: Common.UserInfo
  field :id, 7, type: :int32
end

defmodule Rancher.WorkFlow do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          name: String.t(),
          workable_id: integer,
          workable_type: String.t(),
          remark: String.t(),
          work_flow_nodes: [Rancher.WorkFlowNode.t()],
          work_flow_applies: [Rancher.WorkFlowApply.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :name,
    :workable_id,
    :workable_type,
    :remark,
    :work_flow_nodes,
    :work_flow_applies,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :name, 3, type: :string
  field :workable_id, 4, type: :int32
  field :workable_type, 5, type: :string
  field :remark, 6, type: :string
  field :work_flow_nodes, 7, repeated: true, type: Rancher.WorkFlowNode
  field :work_flow_applies, 8, repeated: true, type: Rancher.WorkFlowApply
  field :created_at, 9, type: :int32
  field :updated_at, 10, type: :int32
end

defmodule Rancher.WorkFlows do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flows: [Rancher.WorkFlow.t()]
        }
  defstruct [:work_flows]

  field :work_flows, 1, repeated: true, type: Rancher.WorkFlow
end

defmodule Rancher.WorkFlowResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          work_flow: Rancher.WorkFlow.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:work_flow, :errors]

  field :work_flow, 1, type: Rancher.WorkFlow
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.FilterOrderBillInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: String.t(),
          code: String.t(),
          amount: String.t(),
          amount_cn: String.t(),
          direction: String.t(),
          billable_id: String.t(),
          billable_type: String.t(),
          remark: String.t()
        }
  defstruct [
    :order_id,
    :code,
    :amount,
    :amount_cn,
    :direction,
    :billable_id,
    :billable_type,
    :remark
  ]

  field :order_id, 1, type: :string
  field :code, 2, type: :string
  field :amount, 3, type: :string
  field :amount_cn, 4, type: :string
  field :direction, 5, type: :string
  field :billable_id, 6, type: :string
  field :billable_type, 7, type: :string
  field :remark, 8, type: :string
end

defmodule Rancher.OrderBillsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Rancher.FilterOrderBillInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          order_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :order_ids]

  field :filter, 1, type: Rancher.FilterOrderBillInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :order_ids, 6, repeated: true, type: :int32
end

defmodule Rancher.CreateOrderBillInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: integer,
          code: String.t(),
          amount: String.t(),
          amount_cn: String.t(),
          direction: integer,
          billable_id: integer,
          billable_type: String.t(),
          remark: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :order_id,
    :code,
    :amount,
    :amount_cn,
    :direction,
    :billable_id,
    :billable_type,
    :remark,
    :user
  ]

  field :order_id, 1, type: :int32
  field :code, 2, type: :string
  field :amount, 3, type: :string
  field :amount_cn, 4, type: :string
  field :direction, 5, type: :int32
  field :billable_id, 6, type: :int32
  field :billable_type, 7, type: :string
  field :remark, 8, type: :string
  field :user, 9, type: Common.UserInfo
end

defmodule Rancher.UpdateOrderBillInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_id: integer,
          code: String.t(),
          amount: String.t(),
          amount_cn: String.t(),
          direction: integer,
          billable_id: integer,
          billable_type: String.t(),
          remark: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :order_id,
    :code,
    :amount,
    :amount_cn,
    :direction,
    :billable_id,
    :billable_type,
    :remark,
    :user,
    :id
  ]

  field :order_id, 1, type: :int32
  field :code, 2, type: :string
  field :amount, 3, type: :string
  field :amount_cn, 4, type: :string
  field :direction, 5, type: :int32
  field :billable_id, 6, type: :int32
  field :billable_type, 7, type: :string
  field :remark, 8, type: :string
  field :user, 9, type: Common.UserInfo
  field :id, 10, type: :int32
end

defmodule Rancher.OrderBill do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          order_id: integer,
          code: String.t(),
          amount: String.t(),
          amount_cn: String.t(),
          direction: integer,
          billable_id: integer,
          billable_type: String.t(),
          remark: String.t(),
          order: Rancher.Order.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :order_id,
    :code,
    :amount,
    :amount_cn,
    :direction,
    :billable_id,
    :billable_type,
    :remark,
    :order,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :order_id, 2, type: :int32
  field :code, 3, type: :string
  field :amount, 4, type: :string
  field :amount_cn, 5, type: :string
  field :direction, 6, type: :int32
  field :billable_id, 7, type: :int32
  field :billable_type, 8, type: :string
  field :remark, 9, type: :string
  field :order, 10, type: Rancher.Order
  field :created_at, 11, type: :int32
  field :updated_at, 12, type: :int32
end

defmodule Rancher.OrderBills do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_bills: [Rancher.OrderBill.t()]
        }
  defstruct [:order_bills]

  field :order_bills, 1, repeated: true, type: Rancher.OrderBill
end

defmodule Rancher.OrderBillResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          order_bill: Rancher.OrderBill.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:order_bill, :errors]

  field :order_bill, 1, type: Rancher.OrderBill
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Rancher.Rancher.Service do
  @moduledoc false
  use GRPC.Service, name: "rancher.Rancher"

  rpc :ListRepo, Common.ID, Rancher.Repo
  rpc :ListRepos, Rancher.ReposParams, Rancher.Repos
  rpc :CreateRepo, Rancher.CreateRepoInput, Rancher.RepoResult
  rpc :UpdateRepo, Rancher.UpdateRepoInput, Rancher.RepoResult
  rpc :DeleteRepo, Common.ID, Common.ActionResult
  rpc :ListRoom, Common.ID, Rancher.Room
  rpc :ListRooms, Rancher.RoomsParams, Rancher.Rooms
  rpc :CreateRoom, Rancher.CreateRoomInput, Rancher.RoomResult
  rpc :UpdateRoom, Rancher.UpdateRoomInput, Rancher.RoomResult
  rpc :DeleteRoom, Common.ID, Common.ActionResult
  rpc :ListSaledReview, Common.ID, Rancher.SaledReview
  rpc :ListSaledReviews, Rancher.SaledReviewsParams, Rancher.SaledReviews
  rpc :CreateSaledReview, Rancher.CreateSaledReviewInput, Rancher.SaledReviewResult
  rpc :UpdateSaledReview, Rancher.UpdateSaledReviewInput, Rancher.SaledReviewResult
  rpc :DeleteSaledReview, Common.ID, Common.ActionResult
  rpc :ListQuote, Common.ID, Rancher.Quote
  rpc :ListQuotes, Rancher.QuotesParams, Rancher.Quotes
  rpc :CreateQuote, Rancher.CreateQuoteInput, Rancher.QuoteResult
  rpc :UpdateQuote, Rancher.UpdateQuoteInput, Rancher.QuoteResult
  rpc :DeleteQuote, Common.ID, Common.ActionResult
  rpc :ListTicket, Common.ID, Rancher.Ticket
  rpc :ListTickets, Rancher.TicketsParams, Rancher.Tickets
  rpc :CreateTicket, Rancher.CreateTicketInput, Rancher.TicketResult
  rpc :UpdateTicket, Rancher.UpdateTicketInput, Rancher.TicketResult
  rpc :DeleteTicket, Common.ID, Common.ActionResult
  rpc :ListTrace, Common.ID, Rancher.Trace
  rpc :ListTraces, Rancher.TracesParams, Rancher.Traces
  rpc :CreateTrace, Rancher.CreateTraceInput, Rancher.TraceResult
  rpc :UpdateTrace, Rancher.UpdateTraceInput, Rancher.TraceResult
  rpc :DeleteTrace, Common.ID, Common.ActionResult
  rpc :ListOrder, Common.ID, Rancher.Order
  rpc :ListOrders, Rancher.OrdersParams, Rancher.Orders
  rpc :CreateOrder, Rancher.CreateOrderInput, Rancher.OrderResult
  rpc :UpdateOrder, Rancher.UpdateOrderInput, Rancher.OrderResult
  rpc :DeleteOrder, Common.ID, Common.ActionResult
  rpc :ListOrderDealPlan, Common.ID, Rancher.OrderDealPlan
  rpc :ListOrderDealPlans, Rancher.OrderDealPlansParams, Rancher.OrderDealPlans
  rpc :CreateOrderDealPlan, Rancher.CreateOrderDealPlanInput, Rancher.OrderDealPlanResult
  rpc :UpdateOrderDealPlan, Rancher.UpdateOrderDealPlanInput, Rancher.OrderDealPlanResult
  rpc :DeleteOrderDealPlan, Common.ID, Common.ActionResult
  rpc :ListOrderDeal, Common.ID, Rancher.OrderDeal
  rpc :ListOrderDeals, Rancher.OrderDealsParams, Rancher.OrderDeals
  rpc :CreateOrderDeal, Rancher.CreateOrderDealInput, Rancher.OrderDealResult
  rpc :UpdateOrderDeal, Rancher.UpdateOrderDealInput, Rancher.OrderDealResult
  rpc :DeleteOrderDeal, Common.ID, Common.ActionResult
  rpc :ListOrderPurchasePlan, Common.ID, Rancher.OrderPurchasePlan
  rpc :ListOrderPurchasePlans, Rancher.OrderPurchasePlansParams, Rancher.OrderPurchasePlans

  rpc :CreateOrderPurchasePlan,
      Rancher.CreateOrderPurchasePlanInput,
      Rancher.OrderPurchasePlanResult

  rpc :UpdateOrderPurchasePlan,
      Rancher.UpdateOrderPurchasePlanInput,
      Rancher.OrderPurchasePlanResult

  rpc :DeleteOrderPurchasePlan, Common.ID, Common.ActionResult
  rpc :ListRepoProduct, Common.ID, Rancher.RepoProduct
  rpc :ListRepoProducts, Rancher.RepoProductsParams, Rancher.RepoProducts
  rpc :CreateRepoProduct, Rancher.CreateRepoProductInput, Rancher.RepoProductResult
  rpc :UpdateRepoProduct, Rancher.UpdateRepoProductInput, Rancher.RepoProductResult
  rpc :DeleteRepoProduct, Common.ID, Common.ActionResult
  rpc :ListRepoReviewAssign, Common.ID, Rancher.RepoReviewAssign
  rpc :ListRepoReviewAssigns, Rancher.RepoReviewAssignsParams, Rancher.RepoReviewAssigns
  rpc :CreateRepoReviewAssign, Rancher.CreateRepoReviewAssignInput, Rancher.RepoReviewAssignResult
  rpc :UpdateRepoReviewAssign, Rancher.UpdateRepoReviewAssignInput, Rancher.RepoReviewAssignResult
  rpc :DeleteRepoReviewAssign, Common.ID, Common.ActionResult
  rpc :ListCase, Common.ID, Rancher.Case
  rpc :ListCases, Rancher.CasesParams, Rancher.Cases
  rpc :CreateCase, Rancher.CreateCaseInput, Rancher.CaseResult
  rpc :UpdateCase, Rancher.UpdateCaseInput, Rancher.CaseResult
  rpc :DeleteCase, Common.ID, Common.ActionResult
  rpc :ListHouse, Common.ID, Rancher.House
  rpc :ListHouses, Rancher.HousesParams, Rancher.Houses
  rpc :CreateHouse, Rancher.CreateHouseInput, Rancher.HouseResult
  rpc :UpdateHouse, Rancher.UpdateHouseInput, Rancher.HouseResult
  rpc :DeleteHouse, Common.ID, Common.ActionResult
  rpc :ListMessage, Common.ID, Rancher.Message
  rpc :ListMessages, Rancher.MessagesParams, Rancher.Messages
  rpc :CreateMessage, Rancher.CreateMessageInput, Rancher.MessageResult
  rpc :UpdateMessage, Rancher.UpdateMessageInput, Rancher.MessageResult
  rpc :DeleteMessage, Common.ID, Common.ActionResult
  rpc :ListPayment, Common.ID, Rancher.Payment
  rpc :ListPayments, Rancher.PaymentsParams, Rancher.Payments
  rpc :CreatePayment, Rancher.CreatePaymentInput, Rancher.PaymentResult
  rpc :UpdatePayment, Rancher.UpdatePaymentInput, Rancher.PaymentResult
  rpc :DeletePayment, Common.ID, Common.ActionResult
  rpc :ListProduct, Common.ID, Rancher.Product
  rpc :ListProducts, Rancher.ProductsParams, Rancher.Products
  rpc :CreateProduct, Rancher.CreateProductInput, Rancher.ProductResult
  rpc :UpdateProduct, Rancher.UpdateProductInput, Rancher.ProductResult
  rpc :DeleteProduct, Common.ID, Common.ActionResult
  rpc :ListCustomer, Common.ID, Rancher.Customer
  rpc :ListCustomers, Rancher.CustomersParams, Rancher.Customers
  rpc :CreateCustomer, Rancher.CreateCustomerInput, Rancher.CustomerResult
  rpc :UpdateCustomer, Rancher.UpdateCustomerInput, Rancher.CustomerResult
  rpc :DeleteCustomer, Common.ID, Common.ActionResult
  rpc :ListOrderPlan, Common.ID, Rancher.OrderPlan
  rpc :ListOrderPlans, Rancher.OrderPlansParams, Rancher.OrderPlans
  rpc :CreateOrderPlan, Rancher.CreateOrderPlanInput, Rancher.OrderPlanResult
  rpc :UpdateOrderPlan, Rancher.UpdateOrderPlanInput, Rancher.OrderPlanResult
  rpc :DeleteOrderPlan, Common.ID, Common.ActionResult
  rpc :ListBuilding, Common.ID, Rancher.Building
  rpc :ListBuildings, Rancher.BuildingsParams, Rancher.Buildings
  rpc :CreateBuilding, Rancher.CreateBuildingInput, Rancher.BuildingResult
  rpc :UpdateBuilding, Rancher.UpdateBuildingInput, Rancher.BuildingResult
  rpc :DeleteBuilding, Common.ID, Common.ActionResult
  rpc :ListRepoReview, Common.ID, Rancher.RepoReview
  rpc :ListRepoReviews, Rancher.RepoReviewsParams, Rancher.RepoReviews
  rpc :CreateRepoReview, Rancher.CreateRepoReviewInput, Rancher.RepoReviewResult
  rpc :UpdateRepoReview, Rancher.UpdateRepoReviewInput, Rancher.RepoReviewResult
  rpc :DeleteRepoReview, Common.ID, Common.ActionResult
  rpc :ListStory, Common.ID, Rancher.Story
  rpc :ListStories, Rancher.StoriesParams, Rancher.Stories
  rpc :CreateStory, Rancher.CreateStoryInput, Rancher.StoryResult
  rpc :UpdateStory, Rancher.UpdateStoryInput, Rancher.StoryResult
  rpc :DeleteStory, Common.ID, Common.ActionResult
  rpc :ListTask, Common.ID, Rancher.Task
  rpc :ListTasks, Rancher.TasksParams, Rancher.Tasks
  rpc :CreateTask, Rancher.CreateTaskInput, Rancher.TaskResult
  rpc :UpdateTask, Rancher.UpdateTaskInput, Rancher.TaskResult
  rpc :DeleteTask, Common.ID, Common.ActionResult
  rpc :ListOrderSale, Common.ID, Rancher.OrderSale
  rpc :ListOrderSales, Rancher.OrderSalesParams, Rancher.OrderSales
  rpc :CreateOrderSale, Rancher.CreateOrderSaleInput, Rancher.OrderSaleResult
  rpc :UpdateOrderSale, Rancher.UpdateOrderSaleInput, Rancher.OrderSaleResult
  rpc :DeleteOrderSale, Common.ID, Common.ActionResult
  rpc :ListProductType, Common.ID, Rancher.ProductType
  rpc :ListProductTypes, Rancher.ProductTypesParams, Rancher.ProductTypes
  rpc :CreateProductType, Rancher.CreateProductTypeInput, Rancher.ProductTypeResult
  rpc :UpdateProductType, Rancher.UpdateProductTypeInput, Rancher.ProductTypeResult
  rpc :DeleteProductType, Common.ID, Common.ActionResult
  rpc :ListSpec, Common.ID, Rancher.Spec
  rpc :ListSpecs, Rancher.SpecsParams, Rancher.Specs
  rpc :CreateSpec, Rancher.CreateSpecInput, Rancher.SpecResult
  rpc :UpdateSpec, Rancher.UpdateSpecInput, Rancher.SpecResult
  rpc :DeleteSpec, Common.ID, Common.ActionResult
  rpc :ListVendor, Common.ID, Rancher.Vendor
  rpc :ListVendors, Rancher.VendorsParams, Rancher.Vendors
  rpc :CreateVendor, Rancher.CreateVendorInput, Rancher.VendorResult
  rpc :UpdateVendor, Rancher.UpdateVendorInput, Rancher.VendorResult
  rpc :DeleteVendor, Common.ID, Common.ActionResult
  rpc :ListVendorScore, Common.ID, Rancher.VendorScore
  rpc :ListVendorScores, Rancher.VendorScoresParams, Rancher.VendorScores
  rpc :CreateVendorScore, Rancher.CreateVendorScoreInput, Rancher.VendorScoreResult
  rpc :UpdateVendorScore, Rancher.UpdateVendorScoreInput, Rancher.VendorScoreResult
  rpc :DeleteVendorScore, Common.ID, Common.ActionResult
  rpc :ListVendorDimension, Common.ID, Rancher.VendorDimension
  rpc :ListVendorDimensions, Rancher.VendorDimensionsParams, Rancher.VendorDimensions
  rpc :CreateVendorDimension, Rancher.CreateVendorDimensionInput, Rancher.VendorDimensionResult
  rpc :UpdateVendorDimension, Rancher.UpdateVendorDimensionInput, Rancher.VendorDimensionResult
  rpc :DeleteVendorDimension, Common.ID, Common.ActionResult
  rpc :ListWorkFlowApply, Common.ID, Rancher.WorkFlowApply
  rpc :ListWorkFlowApplies, Rancher.WorkFlowAppliesParams, Rancher.WorkFlowApplies
  rpc :CreateWorkFlowApply, Rancher.CreateWorkFlowApplyInput, Rancher.WorkFlowApplyResult
  rpc :UpdateWorkFlowApply, Rancher.UpdateWorkFlowApplyInput, Rancher.WorkFlowApplyResult
  rpc :DeleteWorkFlowApply, Common.ID, Common.ActionResult
  rpc :ListWorkFlowNodeBranch, Common.ID, Rancher.WorkFlowNodeBranch
  rpc :ListWorkFlowNodeBranches, Rancher.WorkFlowNodeBranchesParams, Rancher.WorkFlowNodeBranches

  rpc :CreateWorkFlowNodeBranch,
      Rancher.CreateWorkFlowNodeBranchInput,
      Rancher.WorkFlowNodeBranchResult

  rpc :UpdateWorkFlowNodeBranch,
      Rancher.UpdateWorkFlowNodeBranchInput,
      Rancher.WorkFlowNodeBranchResult

  rpc :DeleteWorkFlowNodeBranch, Common.ID, Common.ActionResult
  rpc :ListWorkFlowNode, Common.ID, Rancher.WorkFlowNode
  rpc :ListWorkFlowNodes, Rancher.WorkFlowNodesParams, Rancher.WorkFlowNodes
  rpc :CreateWorkFlowNode, Rancher.CreateWorkFlowNodeInput, Rancher.WorkFlowNodeResult
  rpc :UpdateWorkFlowNode, Rancher.UpdateWorkFlowNodeInput, Rancher.WorkFlowNodeResult
  rpc :DeleteWorkFlowNode, Common.ID, Common.ActionResult
  rpc :ListWorkFlowProcess, Common.ID, Rancher.WorkFlowProcess
  rpc :ListWorkFlowProcesses, Rancher.WorkFlowProcessesParams, Rancher.WorkFlowProcesses
  rpc :CreateWorkFlowProcess, Rancher.CreateWorkFlowProcessInput, Rancher.WorkFlowProcessResult
  rpc :UpdateWorkFlowProcess, Rancher.UpdateWorkFlowProcessInput, Rancher.WorkFlowProcessResult
  rpc :DeleteWorkFlowProcess, Common.ID, Common.ActionResult
  rpc :ListWorkFlow, Common.ID, Rancher.WorkFlow
  rpc :ListWorkFlows, Rancher.WorkFlowsParams, Rancher.WorkFlows
  rpc :CreateWorkFlow, Rancher.CreateWorkFlowInput, Rancher.WorkFlowResult
  rpc :UpdateWorkFlow, Rancher.UpdateWorkFlowInput, Rancher.WorkFlowResult
  rpc :DeleteWorkFlow, Common.ID, Common.ActionResult
  rpc :ListOrderBill, Common.ID, Rancher.OrderBill
  rpc :ListOrderBills, Rancher.OrderBillsParams, Rancher.OrderBills
  rpc :CreateOrderBill, Rancher.CreateOrderBillInput, Rancher.OrderBillResult
  rpc :UpdateOrderBill, Rancher.UpdateOrderBillInput, Rancher.OrderBillResult
  rpc :DeleteOrderBill, Common.ID, Common.ActionResult
end

defmodule Rancher.Rancher.Stub do
  @moduledoc false
  use GRPC.Stub, service: Rancher.Rancher.Service
end
