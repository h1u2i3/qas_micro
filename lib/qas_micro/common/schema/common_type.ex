defmodule QasMicro.Common.Schema.CommonType do
  use Absinthe.Schema.Notation

  enum :sort_order do
    value(:asc)
    value(:desc)
    value(:special)
  end

  input_object :order_input do
    field(:name, :string)
    field(:order, :sort_order, default_value: :asc)
  end

  input_object :paginate_input do
    field(:limit, :integer)
    field(:offset, :integer)
  end

  #
  # 微信及微信相关
  #

  object :jsapi_params do
    field(:url, :string)
    field(:timestamp, :string)
    field(:noncestr, :string)
    field(:signature, :string)
    field(:appid, :string)
  end

  input_object :wechat_jsapi_pay_input do
    field(:body, non_null(:string))
    field(:out_trade_no, non_null(:string))
  end

  object :wechat_jsapi_pay do
    field(:app_id, :string)
    field(:package, :string)
    field(:nonce_str, :string)
    field(:time_stamp, :string)
    field(:sign_type, :string)
    field(:pay_sign, :string)
  end

  input_object :wechat_pay_sign_input do
    field(:body, non_null(:string))
    field(:out_trade_no, non_null(:string))
  end

  object :wechat_app_pay_order do
    field(:partner_id, :string)
    field(:prepay_id, :string)
    field(:nonce_str, :string)
    field(:time_stamp, :string)
    field(:package, :string)
    field(:sign, :string)
  end

  #
  # 支付宝及支付宝相关
  #

  input_object :alipay_app_pay_input do
    field(:subject, non_null(:string))
    field(:out_trade_no, non_null(:string))
  end

  object :alipay_order_string do
    field(:order_str, :string)
  end

  object :action_result do
    field(:status, :string)
    field(:message, :string)
  end

  object :normal_error do
    field(:key, :string)
    field(:message, :string)
  end

  object :count_result do
    field(:total_count, :integer)
  end
end
