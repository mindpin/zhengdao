class PayDefine
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :pay_items

  field :name # 收费项名称
  field :desc # 收费项描述
  field :unit_price # 收费项单价  
end