class PeRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :patient_record
  belongs_to :pe_define

  # 体检记录语句
  has_many :sentences, class_name: 'PeSentence'

  # 体检大项结论
  field :conclusion
end