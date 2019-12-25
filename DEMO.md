```
service do
  @name(account)
  @server(yimei-account.openfaas-fn.svc.cluster.local)
  @port(8080)

  object do
    @name(user)
    @timestamp
    field do
      +string(name)             # 名称
      +string(avatar)           # 头像
      +string(cellphone)        # 手机号码
      +string(wechat_digest)    # 微信openid
    end
  end

  object do
    @name(organization)
    @timestamp
    field do
      +string(name)             # 组织名称
      +string(category)         # 组织类别
      +string(avatar)           # 组织头像
      +json(basic_setting)      # 基础设置
      +json(desktop_setting)    # 机构桌面版设置
      +json(payment_setting)    # 支付设置，关系到支付进行金额分配等的设置
    end
  end

  object do
    @name(doctor)
    @timestamp
    field do
      +string(name)
      +string(hospital)
      +string(title)
      +string(department)
      +string(description)
      +integer(organization_id)
    end
  end

  # 一个用户可能在不同的机构里面有不同的登录账号
  # 因此增加 Login 作为登录凭据，里面包含用户名和密码
  object do
    @name(login)
    @timestamp
    field do
      +integer(organization_id)
      +integer(user_id)
      +string(username)
      +string(role)
    end
  end

  object do
    @name(login_permission)
    @timestamp
    field do
      +integer(login_id)
      +json(permission_setting)
    end
  end
end
```