defmodule QasMicro.Code.Generator.Plugin.Abilities do
  use QasMicro.Code.Genetator.Template

  import QasMicro.Util.Helper

  alias QasMicro.Util.Unit
  alias QasMicro.Util.Map, as: QMap

  @external_resource Path.join(__DIR__, "abilities.eex")

  def render(config_module) do
    abilities_module_name = config_module.abilities_module()
    object = config_module.parse_object()

    auth_object =
      config_module.parse_object()
      |> Enum.filter(&QMap.get(&1, :"plugin.auth"))

    if !Enum.empty?(auth_object) do
      auth_resources = Enum.map(auth_object, &config_module.model_module(&1.name))

      permissions =
        Enum.map(object, fn object_item ->
          auth_resources
          |> Enum.map(fn auth_resource ->
            auth_resource_name = model_name_from_module(auth_resource)
            resource_name = config_module.model_module(object_item.name)

            permission_config = QMap.get(object_item, :"permission.#{auth_resource_name}")

            if permission_config do
              Enum.map(permission_config, fn {action, action_config} ->
                :action
                |> parse_permission(action_config)
                |> Enum.map(fn
                  # self resource
                  {k, [_, _] = ids} ->
                    self_render(k, action, ids, auth_resource, resource_name)

                  # join resource
                  {k, [_, _, _, _] = ids} ->
                    middle_render(k, action, ids, config_module, auth_resource, resource_name)

                  {k, true} ->
                    if k == :visitor do
                      """
                      def can?(
                        #{Unit.new(k)},
                        nil,
                        :#{action},
                        %Changeset{data: %#{resource_name}{}}
                      ), do: true
                      """
                    else
                      """
                      def can?(
                        #{Unit.new(k)},
                        %#{auth_resource}{},
                        :#{action},
                        %Changeset{data: %#{resource_name}{}}
                      ), do: true
                      """
                    end
                end)
              end)
            else
              """
              def can?(
                _,
                %#{auth_resource}{},
                _,
                %Changeset{data: %#{resource_name}{}}
              ), do: false
              """
              |> List.wrap()
            end
            |> List.flatten()
          end)
        end)

      eex_template_string()
      |> EEx.eval_string(abilities_module_name: abilities_module_name, permissions: permissions)
      |> config_module.save_file("abilities.ex")
    else
      raise("""
      You must add a auth model to do abilities check.

      @plugin(~w/auth,password,wechat/a)
      @plugin(:auth)
      """)
    end
  end

  defp self_render(role, action, ids, auth_module, resource) do
    [id, relation_id] = ids

    if action == :create do
      """
      def can?(
        #{Unit.new(role)},
        %#{auth_module}{#{id}: id},
        :#{action},
        %Changeset{changes: %{#{relation_id}: id}, data: %#{resource}{}}
      ), do: true

      def can?(
        #{Unit.new(role)},
        %#{auth_module}{},
        :#{action},
        %Changeset{data: %#{resource}{}}
      ), do: false
      """
    else
      """
      def can?(
        #{Unit.new(role)},
        %#{auth_module}{#{id}: id},
        :#{action},
        %Changeset{changes: %{#{relation_id}: change_id}, data: %#{resource}{#{relation_id}: id}}
      ), do: change_id == id

      def can?(
        #{Unit.new(role)},
        %#{auth_module}{#{id}: id},
        :#{action},
        %Changeset{data: %#{resource}{#{relation_id}: id}}
      ), do: true

      def can?(
        #{Unit.new(role)},
        %#{auth_module}{},
        :#{action},
        %Changeset{data: %#{resource}{}}
      ), do: false
      """
    end
  end

  # ~a/user_coupon,id,user_id,coupon_id/
  defp middle_render(role, action, ids, config_module, auth_module, resource) do
    [relation, id, auth_id, relation_id] = ids
    relation_module = relation |> Atom.to_string() |> config_module.model_module()
    repo = config_module.repo_module()

    if action == :create do
      """
      def can?(
        #{Unit.new(role)},
        %#{auth_module}{#{id}: auth_id},
        :#{action},
        %Changeset{changes: %{#{relation_id}: relation_id}}
      ) do
        #{repo}.get_by(#{relation_module}, #{auth_id}: auth_id, #{relation_id}: relation_id)
      end

      def can?(
        #{Unit.new(role)},
        %#{auth_module}{},
        :#{action},
        _
      ), do: false
      """
    else
      """
      def can?(
        #{Unit.new(role)},
        %#{auth_module}{#{id}: auth_id},
        :#{action},
        %Changeset{changes: %{#{relation_id}: relation_id}, data: %#{resource}{#{relation_id}: relation_id}}
      ) do
        #{repo}.get_by(#{relation_module}, #{auth_id}: auth_id, #{relation_id}: relation_id)
      end

      def can?(
        #{Unit.new(role)},
        %#{auth_module}{},
        :#{action},
        %Changeset{data: %#{resource}{}}
      ), do: false
      """
    end
  end
end
