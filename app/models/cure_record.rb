class CureRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :patient_record

  field :name # 治疗项名称
  field :conclusion # 治疗项结论
  field :response # 用户反馈记录
end