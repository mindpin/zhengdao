class PayItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :patient_record

  belongs_to :pay_define # 关联收费项
  field :amount # 数量
  field :total_price # 总价
  field :is_paid # 是否已缴费
end