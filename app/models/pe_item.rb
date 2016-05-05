class PeItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :pe_record

  field :label # 记录小项名
  field :value # 记录小项值
  field :memo  # 记录小项补充备注
end