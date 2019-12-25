defmodule Admin.FilterUserInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          user_name: String.t(),
          typeable_id: String.t(),
          typeable_type: String.t(),
          status: String.t()
        }
  defstruct [:user_name, :typeable_id, :typeable_type, :status]

  field :user_name, 1, type: :string
  field :typeable_id, 2, type: :string
  field :typeable_type, 3, type: :string
  field :status, 4, type: :string
end

defmodule Admin.UsersParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Admin.FilterUserInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids]

  field :filter, 1, type: Admin.FilterUserInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
end

defmodule Admin.CreateUserInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          user_name: String.t(),
          password: String.t(),
          typeable_id: integer,
          typeable_type: String.t(),
          status: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:user_name, :password, :typeable_id, :typeable_type, :status, :user]

  field :user_name, 1, type: :string
  field :password, 2, type: :string
  field :typeable_id, 3, type: :int32
  field :typeable_type, 4, type: :string
  field :status, 5, type: :string
  field :user, 6, type: Common.UserInfo
end

defmodule Admin.UpdateUserInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          user_name: String.t(),
          password: String.t(),
          typeable_id: integer,
          typeable_type: String.t(),
          status: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:user_name, :password, :typeable_id, :typeable_type, :status, :user, :id]

  field :user_name, 1, type: :string
  field :password, 2, type: :string
  field :typeable_id, 3, type: :int32
  field :typeable_type, 4, type: :string
  field :status, 5, type: :string
  field :user, 6, type: Common.UserInfo
  field :id, 7, type: :int32
end

defmodule Admin.User do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          user_name: String.t(),
          password: String.t(),
          typeable_id: integer,
          typeable_type: String.t(),
          status: String.t(),
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :user_name,
    :password,
    :typeable_id,
    :typeable_type,
    :status,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :user_name, 2, type: :string
  field :password, 3, type: :string
  field :typeable_id, 4, type: :int32
  field :typeable_type, 5, type: :string
  field :status, 6, type: :string
  field :created_at, 7, type: :int32
  field :updated_at, 8, type: :int32
end

defmodule Admin.Users do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          users: [Admin.User.t()]
        }
  defstruct [:users]

  field :users, 1, repeated: true, type: Admin.User
end

defmodule Admin.UserResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          user: Admin.User.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:user, :errors]

  field :user, 1, type: Admin.User
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Admin.FilterOrgInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          address: String.t(),
          employee_id: String.t(),
          status: String.t()
        }
  defstruct [:code, :name, :address, :employee_id, :status]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :address, 3, type: :string
  field :employee_id, 4, type: :string
  field :status, 5, type: :string
end

defmodule Admin.OrgsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Admin.FilterOrgInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          employee_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :employee_ids]

  field :filter, 1, type: Admin.FilterOrgInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :employee_ids, 6, repeated: true, type: :int32
end

defmodule Admin.CreateOrgInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          address: String.t(),
          employee_id: integer,
          status: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :name, :address, :employee_id, :status, :user]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :address, 3, type: :string
  field :employee_id, 4, type: :int32
  field :status, 5, type: :string
  field :user, 6, type: Common.UserInfo
end

defmodule Admin.UpdateOrgInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          address: String.t(),
          employee_id: integer,
          status: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :name, :address, :employee_id, :status, :user, :id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :address, 3, type: :string
  field :employee_id, 4, type: :int32
  field :status, 5, type: :string
  field :user, 6, type: Common.UserInfo
  field :id, 7, type: :int32
end

defmodule Admin.Org do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          name: String.t(),
          address: String.t(),
          employee_id: integer,
          status: String.t(),
          employee: Admin.Employee.t() | nil,
          departments: [Admin.Department.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :name,
    :address,
    :employee_id,
    :status,
    :employee,
    :departments,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :name, 3, type: :string
  field :address, 4, type: :string
  field :employee_id, 5, type: :int32
  field :status, 6, type: :string
  field :employee, 7, type: Admin.Employee
  field :departments, 8, repeated: true, type: Admin.Department
  field :created_at, 9, type: :int32
  field :updated_at, 10, type: :int32
end

defmodule Admin.Orgs do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          orgs: [Admin.Org.t()]
        }
  defstruct [:orgs]

  field :orgs, 1, repeated: true, type: Admin.Org
end

defmodule Admin.OrgResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          org: Admin.Org.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:org, :errors]

  field :org, 1, type: Admin.Org
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Admin.FilterDutyInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          role_id: String.t()
        }
  defstruct [:code, :name, :role_id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :role_id, 3, type: :string
end

defmodule Admin.DutiesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Admin.FilterDutyInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          role_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :role_ids]

  field :filter, 1, type: Admin.FilterDutyInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :role_ids, 6, repeated: true, type: :int32
end

defmodule Admin.CreateDutyInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          role_id: integer,
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :name, :role_id, :user]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :role_id, 3, type: :int32
  field :user, 4, type: Common.UserInfo
end

defmodule Admin.UpdateDutyInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          role_id: integer,
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :name, :role_id, :user, :id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :role_id, 3, type: :int32
  field :user, 4, type: Common.UserInfo
  field :id, 5, type: :int32
end

defmodule Admin.Duty do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          name: String.t(),
          role_id: integer,
          role: Admin.Role.t() | nil,
          employees: [Admin.Employee.t()],
          accesses: [Admin.Access.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [:id, :code, :name, :role_id, :role, :employees, :accesses, :created_at, :updated_at]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :name, 3, type: :string
  field :role_id, 4, type: :int32
  field :role, 5, type: Admin.Role
  field :employees, 6, repeated: true, type: Admin.Employee
  field :accesses, 7, repeated: true, type: Admin.Access
  field :created_at, 8, type: :int32
  field :updated_at, 9, type: :int32
end

defmodule Admin.Duties do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          duties: [Admin.Duty.t()]
        }
  defstruct [:duties]

  field :duties, 1, repeated: true, type: Admin.Duty
end

defmodule Admin.DutyResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          duty: Admin.Duty.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:duty, :errors]

  field :duty, 1, type: Admin.Duty
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Admin.FilterEntityInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          alias: String.t()
        }
  defstruct [:code, :name, :alias]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :alias, 3, type: :string
end

defmodule Admin.EntitiesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Admin.FilterEntityInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids]

  field :filter, 1, type: Admin.FilterEntityInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
end

defmodule Admin.CreateEntityInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          alias: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :name, :alias, :user]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :alias, 3, type: :string
  field :user, 4, type: Common.UserInfo
end

defmodule Admin.UpdateEntityInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          alias: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :name, :alias, :user, :id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :alias, 3, type: :string
  field :user, 4, type: Common.UserInfo
  field :id, 5, type: :int32
end

defmodule Admin.Entity do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          name: String.t(),
          alias: String.t(),
          operations: [Admin.Operation.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [:id, :code, :name, :alias, :operations, :created_at, :updated_at]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :name, 3, type: :string
  field :alias, 4, type: :string
  field :operations, 5, repeated: true, type: Admin.Operation
  field :created_at, 6, type: :int32
  field :updated_at, 7, type: :int32
end

defmodule Admin.Entities do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          entities: [Admin.Entity.t()]
        }
  defstruct [:entities]

  field :entities, 1, repeated: true, type: Admin.Entity
end

defmodule Admin.EntityResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          entity: Admin.Entity.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:entity, :errors]

  field :entity, 1, type: Admin.Entity
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Admin.FilterDepartmentInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          department_id: String.t(),
          employee_id: String.t(),
          org_id: String.t(),
          status: String.t()
        }
  defstruct [:code, :name, :department_id, :employee_id, :org_id, :status]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :department_id, 3, type: :string
  field :employee_id, 4, type: :string
  field :org_id, 5, type: :string
  field :status, 6, type: :string
end

defmodule Admin.DepartmentsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Admin.FilterDepartmentInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          org_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :org_ids]

  field :filter, 1, type: Admin.FilterDepartmentInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :org_ids, 6, repeated: true, type: :int32
end

defmodule Admin.CreateDepartmentInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          department_id: integer,
          employee_id: integer,
          org_id: integer,
          status: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :name, :department_id, :employee_id, :org_id, :status, :user]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :department_id, 3, type: :int32
  field :employee_id, 4, type: :int32
  field :org_id, 5, type: :int32
  field :status, 6, type: :string
  field :user, 7, type: Common.UserInfo
end

defmodule Admin.UpdateDepartmentInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          name: String.t(),
          department_id: integer,
          employee_id: integer,
          org_id: integer,
          status: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :name, :department_id, :employee_id, :org_id, :status, :user, :id]

  field :code, 1, type: :string
  field :name, 2, type: :string
  field :department_id, 3, type: :int32
  field :employee_id, 4, type: :int32
  field :org_id, 5, type: :int32
  field :status, 6, type: :string
  field :user, 7, type: Common.UserInfo
  field :id, 8, type: :int32
end

defmodule Admin.Department do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          name: String.t(),
          department_id: integer,
          employee_id: integer,
          org_id: integer,
          status: String.t(),
          org: Admin.Org.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :name,
    :department_id,
    :employee_id,
    :org_id,
    :status,
    :org,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :name, 3, type: :string
  field :department_id, 4, type: :int32
  field :employee_id, 5, type: :int32
  field :org_id, 6, type: :int32
  field :status, 7, type: :string
  field :org, 8, type: Admin.Org
  field :created_at, 9, type: :int32
  field :updated_at, 10, type: :int32
end

defmodule Admin.Departments do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          departments: [Admin.Department.t()]
        }
  defstruct [:departments]

  field :departments, 1, repeated: true, type: Admin.Department
end

defmodule Admin.DepartmentResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          department: Admin.Department.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:department, :errors]

  field :department, 1, type: Admin.Department
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Admin.FilterRoleInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          org_id: String.t(),
          name: String.t()
        }
  defstruct [:code, :org_id, :name]

  field :code, 1, type: :string
  field :org_id, 2, type: :string
  field :name, 3, type: :string
end

defmodule Admin.RolesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Admin.FilterRoleInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          org_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :org_ids]

  field :filter, 1, type: Admin.FilterRoleInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :org_ids, 6, repeated: true, type: :int32
end

defmodule Admin.CreateRoleInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          org_id: integer,
          name: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:code, :org_id, :name, :user]

  field :code, 1, type: :string
  field :org_id, 2, type: :int32
  field :name, 3, type: :string
  field :user, 4, type: Common.UserInfo
end

defmodule Admin.UpdateRoleInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          org_id: integer,
          name: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:code, :org_id, :name, :user, :id]

  field :code, 1, type: :string
  field :org_id, 2, type: :int32
  field :name, 3, type: :string
  field :user, 4, type: Common.UserInfo
  field :id, 5, type: :int32
end

defmodule Admin.Role do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          org_id: integer,
          name: String.t(),
          org: Admin.Org.t() | nil,
          operations: [Admin.Operation.t()],
          duties: [Admin.Duty.t()],
          created_at: integer,
          updated_at: integer
        }
  defstruct [:id, :code, :org_id, :name, :org, :operations, :duties, :created_at, :updated_at]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :org_id, 3, type: :int32
  field :name, 4, type: :string
  field :org, 5, type: Admin.Org
  field :operations, 6, repeated: true, type: Admin.Operation
  field :duties, 7, repeated: true, type: Admin.Duty
  field :created_at, 8, type: :int32
  field :updated_at, 9, type: :int32
end

defmodule Admin.Roles do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          roles: [Admin.Role.t()]
        }
  defstruct [:roles]

  field :roles, 1, repeated: true, type: Admin.Role
end

defmodule Admin.RoleResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          role: Admin.Role.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:role, :errors]

  field :role, 1, type: Admin.Role
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Admin.FilterEmployeeInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          department_id: String.t(),
          duty_id: String.t(),
          sex: String.t(),
          age: String.t(),
          name: String.t(),
          cellphone: String.t(),
          status: String.t(),
          alias: String.t(),
          birth: String.t(),
          email: String.t()
        }
  defstruct [
    :code,
    :department_id,
    :duty_id,
    :sex,
    :age,
    :name,
    :cellphone,
    :status,
    :alias,
    :birth,
    :email
  ]

  field :code, 1, type: :string
  field :department_id, 2, type: :string
  field :duty_id, 3, type: :string
  field :sex, 4, type: :string
  field :age, 5, type: :string
  field :name, 6, type: :string
  field :cellphone, 7, type: :string
  field :status, 8, type: :string
  field :alias, 9, type: :string
  field :birth, 10, type: :string
  field :email, 11, type: :string
end

defmodule Admin.EmployeesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Admin.FilterEmployeeInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          duty_ids: [integer],
          department_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :duty_ids, :department_ids]

  field :filter, 1, type: Admin.FilterEmployeeInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :duty_ids, 6, repeated: true, type: :int32
  field :department_ids, 7, repeated: true, type: :int32
end

defmodule Admin.CreateEmployeeInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          avatar: String.t(),
          department_id: integer,
          duty_id: integer,
          sex: String.t(),
          age: integer,
          name: String.t(),
          cellphone: String.t(),
          status: String.t(),
          alias: String.t(),
          birth: integer,
          email: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [
    :code,
    :avatar,
    :department_id,
    :duty_id,
    :sex,
    :age,
    :name,
    :cellphone,
    :status,
    :alias,
    :birth,
    :email,
    :user
  ]

  field :code, 1, type: :string
  field :avatar, 2, type: :string
  field :department_id, 3, type: :int32
  field :duty_id, 4, type: :int32
  field :sex, 5, type: :string
  field :age, 6, type: :int32
  field :name, 7, type: :string
  field :cellphone, 8, type: :string
  field :status, 9, type: :string
  field :alias, 10, type: :string
  field :birth, 11, type: :int32
  field :email, 12, type: :string
  field :user, 13, type: Common.UserInfo
end

defmodule Admin.UpdateEmployeeInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: String.t(),
          avatar: String.t(),
          department_id: integer,
          duty_id: integer,
          sex: String.t(),
          age: integer,
          name: String.t(),
          cellphone: String.t(),
          status: String.t(),
          alias: String.t(),
          birth: integer,
          email: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [
    :code,
    :avatar,
    :department_id,
    :duty_id,
    :sex,
    :age,
    :name,
    :cellphone,
    :status,
    :alias,
    :birth,
    :email,
    :user,
    :id
  ]

  field :code, 1, type: :string
  field :avatar, 2, type: :string
  field :department_id, 3, type: :int32
  field :duty_id, 4, type: :int32
  field :sex, 5, type: :string
  field :age, 6, type: :int32
  field :name, 7, type: :string
  field :cellphone, 8, type: :string
  field :status, 9, type: :string
  field :alias, 10, type: :string
  field :birth, 11, type: :int32
  field :email, 12, type: :string
  field :user, 13, type: Common.UserInfo
  field :id, 14, type: :int32
end

defmodule Admin.Employee do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          code: String.t(),
          avatar: String.t(),
          department_id: integer,
          duty_id: integer,
          sex: String.t(),
          age: integer,
          name: String.t(),
          cellphone: String.t(),
          status: String.t(),
          alias: String.t(),
          birth: integer,
          email: String.t(),
          duty: Admin.Duty.t() | nil,
          department: Admin.Department.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [
    :id,
    :code,
    :avatar,
    :department_id,
    :duty_id,
    :sex,
    :age,
    :name,
    :cellphone,
    :status,
    :alias,
    :birth,
    :email,
    :duty,
    :department,
    :created_at,
    :updated_at
  ]

  field :id, 1, type: :int32
  field :code, 2, type: :string
  field :avatar, 3, type: :string
  field :department_id, 4, type: :int32
  field :duty_id, 5, type: :int32
  field :sex, 6, type: :string
  field :age, 7, type: :int32
  field :name, 8, type: :string
  field :cellphone, 9, type: :string
  field :status, 10, type: :string
  field :alias, 11, type: :string
  field :birth, 12, type: :int32
  field :email, 13, type: :string
  field :duty, 14, type: Admin.Duty
  field :department, 15, type: Admin.Department
  field :created_at, 16, type: :int32
  field :updated_at, 17, type: :int32
end

defmodule Admin.Employees do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          employees: [Admin.Employee.t()]
        }
  defstruct [:employees]

  field :employees, 1, repeated: true, type: Admin.Employee
end

defmodule Admin.EmployeeResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          employee: Admin.Employee.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:employee, :errors]

  field :employee, 1, type: Admin.Employee
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Admin.FilterOperationInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          role_id: String.t(),
          entity_id: String.t(),
          auths: String.t()
        }
  defstruct [:role_id, :entity_id, :auths]

  field :role_id, 1, type: :string
  field :entity_id, 2, type: :string
  field :auths, 3, type: :string
end

defmodule Admin.OperationsParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Admin.FilterOperationInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          role_ids: [integer],
          entity_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :role_ids, :entity_ids]

  field :filter, 1, type: Admin.FilterOperationInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :role_ids, 6, repeated: true, type: :int32
  field :entity_ids, 7, repeated: true, type: :int32
end

defmodule Admin.CreateOperationInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          role_id: integer,
          entity_id: integer,
          auths: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:role_id, :entity_id, :auths, :user]

  field :role_id, 1, type: :int32
  field :entity_id, 2, type: :int32
  field :auths, 3, type: :string
  field :user, 4, type: Common.UserInfo
end

defmodule Admin.UpdateOperationInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          role_id: integer,
          entity_id: integer,
          auths: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:role_id, :entity_id, :auths, :user, :id]

  field :role_id, 1, type: :int32
  field :entity_id, 2, type: :int32
  field :auths, 3, type: :string
  field :user, 4, type: Common.UserInfo
  field :id, 5, type: :int32
end

defmodule Admin.Operation do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          role_id: integer,
          entity_id: integer,
          auths: String.t(),
          role: Admin.Role.t() | nil,
          entity: Admin.Entity.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [:id, :role_id, :entity_id, :auths, :role, :entity, :created_at, :updated_at]

  field :id, 1, type: :int32
  field :role_id, 2, type: :int32
  field :entity_id, 3, type: :int32
  field :auths, 4, type: :string
  field :role, 5, type: Admin.Role
  field :entity, 6, type: Admin.Entity
  field :created_at, 7, type: :int32
  field :updated_at, 8, type: :int32
end

defmodule Admin.Operations do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          operations: [Admin.Operation.t()]
        }
  defstruct [:operations]

  field :operations, 1, repeated: true, type: Admin.Operation
end

defmodule Admin.OperationResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          operation: Admin.Operation.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:operation, :errors]

  field :operation, 1, type: Admin.Operation
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Admin.FilterAccessInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          duty_id: String.t(),
          org_list: String.t()
        }
  defstruct [:duty_id, :org_list]

  field :duty_id, 1, type: :string
  field :org_list, 2, type: :string
end

defmodule Admin.AccessesParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: Admin.FilterAccessInput.t() | nil,
          order: [Common.OrderItem.t()],
          paginate: Common.PaginateInput.t() | nil,
          user: Common.UserInfo.t() | nil,
          ids: [integer],
          duty_ids: [integer]
        }
  defstruct [:filter, :order, :paginate, :user, :ids, :duty_ids]

  field :filter, 1, type: Admin.FilterAccessInput
  field :order, 2, repeated: true, type: Common.OrderItem
  field :paginate, 3, type: Common.PaginateInput
  field :user, 4, type: Common.UserInfo
  field :ids, 5, repeated: true, type: :int32
  field :duty_ids, 6, repeated: true, type: :int32
end

defmodule Admin.CreateAccessInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          duty_id: integer,
          org_list: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:duty_id, :org_list, :user]

  field :duty_id, 1, type: :int32
  field :org_list, 2, type: :string
  field :user, 3, type: Common.UserInfo
end

defmodule Admin.UpdateAccessInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          duty_id: integer,
          org_list: String.t(),
          user: Common.UserInfo.t() | nil,
          id: integer
        }
  defstruct [:duty_id, :org_list, :user, :id]

  field :duty_id, 1, type: :int32
  field :org_list, 2, type: :string
  field :user, 3, type: Common.UserInfo
  field :id, 4, type: :int32
end

defmodule Admin.Access do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: integer,
          duty_id: integer,
          org_list: String.t(),
          duty: Admin.Duty.t() | nil,
          created_at: integer,
          updated_at: integer
        }
  defstruct [:id, :duty_id, :org_list, :duty, :created_at, :updated_at]

  field :id, 1, type: :int32
  field :duty_id, 2, type: :int32
  field :org_list, 3, type: :string
  field :duty, 4, type: Admin.Duty
  field :created_at, 5, type: :int32
  field :updated_at, 6, type: :int32
end

defmodule Admin.Accesses do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          accesses: [Admin.Access.t()]
        }
  defstruct [:accesses]

  field :accesses, 1, repeated: true, type: Admin.Access
end

defmodule Admin.AccessResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          access: Admin.Access.t() | nil,
          errors: [Common.NormalError.t()]
        }
  defstruct [:access, :errors]

  field :access, 1, type: Admin.Access
  field :errors, 2, repeated: true, type: Common.NormalError
end

defmodule Admin.AuthUser do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          user: Admin.User.t() | nil,
          app: String.t(),
          model: String.t(),
          id: integer
        }
  defstruct [:user, :app, :model, :id]

  field :user, 1, type: Admin.User
  field :app, 2, type: :string
  field :model, 3, type: :string
  field :id, 4, type: :int32
end

defmodule Admin.AuthUserInput do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          password: String.t(),
          user: Common.UserInfo.t() | nil
        }
  defstruct [:name, :password, :user]

  field :name, 1, type: :string
  field :password, 2, type: :string
  field :user, 3, type: Common.UserInfo
end

defmodule Admin.Admin.Service do
  @moduledoc false
  use GRPC.Service, name: "admin.Admin"

  rpc :ListUser, Common.ID, Admin.User
  rpc :ListUsers, Admin.UsersParams, Admin.Users
  rpc :CreateUser, Admin.CreateUserInput, Admin.UserResult
  rpc :UpdateUser, Admin.UpdateUserInput, Admin.UserResult
  rpc :DeleteUser, Common.ID, Common.ActionResult
  rpc :ListOrg, Common.ID, Admin.Org
  rpc :ListOrgs, Admin.OrgsParams, Admin.Orgs
  rpc :CreateOrg, Admin.CreateOrgInput, Admin.OrgResult
  rpc :UpdateOrg, Admin.UpdateOrgInput, Admin.OrgResult
  rpc :DeleteOrg, Common.ID, Common.ActionResult
  rpc :ListDuty, Common.ID, Admin.Duty
  rpc :ListDuties, Admin.DutiesParams, Admin.Duties
  rpc :CreateDuty, Admin.CreateDutyInput, Admin.DutyResult
  rpc :UpdateDuty, Admin.UpdateDutyInput, Admin.DutyResult
  rpc :DeleteDuty, Common.ID, Common.ActionResult
  rpc :ListEntity, Common.ID, Admin.Entity
  rpc :ListEntities, Admin.EntitiesParams, Admin.Entities
  rpc :CreateEntity, Admin.CreateEntityInput, Admin.EntityResult
  rpc :UpdateEntity, Admin.UpdateEntityInput, Admin.EntityResult
  rpc :DeleteEntity, Common.ID, Common.ActionResult
  rpc :ListDepartment, Common.ID, Admin.Department
  rpc :ListDepartments, Admin.DepartmentsParams, Admin.Departments
  rpc :CreateDepartment, Admin.CreateDepartmentInput, Admin.DepartmentResult
  rpc :UpdateDepartment, Admin.UpdateDepartmentInput, Admin.DepartmentResult
  rpc :DeleteDepartment, Common.ID, Common.ActionResult
  rpc :ListRole, Common.ID, Admin.Role
  rpc :ListRoles, Admin.RolesParams, Admin.Roles
  rpc :CreateRole, Admin.CreateRoleInput, Admin.RoleResult
  rpc :UpdateRole, Admin.UpdateRoleInput, Admin.RoleResult
  rpc :DeleteRole, Common.ID, Common.ActionResult
  rpc :ListEmployee, Common.ID, Admin.Employee
  rpc :ListEmployees, Admin.EmployeesParams, Admin.Employees
  rpc :CreateEmployee, Admin.CreateEmployeeInput, Admin.EmployeeResult
  rpc :UpdateEmployee, Admin.UpdateEmployeeInput, Admin.EmployeeResult
  rpc :DeleteEmployee, Common.ID, Common.ActionResult
  rpc :ListOperation, Common.ID, Admin.Operation
  rpc :ListOperations, Admin.OperationsParams, Admin.Operations
  rpc :CreateOperation, Admin.CreateOperationInput, Admin.OperationResult
  rpc :UpdateOperation, Admin.UpdateOperationInput, Admin.OperationResult
  rpc :DeleteOperation, Common.ID, Common.ActionResult
  rpc :ListAccess, Common.ID, Admin.Access
  rpc :ListAccesses, Admin.AccessesParams, Admin.Accesses
  rpc :CreateAccess, Admin.CreateAccessInput, Admin.AccessResult
  rpc :UpdateAccess, Admin.UpdateAccessInput, Admin.AccessResult
  rpc :DeleteAccess, Common.ID, Common.ActionResult
  rpc :CreateAuthUser, Admin.AuthUserInput, Admin.AuthUser
end

defmodule Admin.Admin.Stub do
  @moduledoc false
  use GRPC.Stub, service: Admin.Admin.Service
end
