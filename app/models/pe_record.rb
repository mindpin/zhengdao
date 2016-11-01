class PeRecord
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :patient_record
  belongs_to :pe_define

  # 体检记录语句
  has_many :sentences, class_name: 'PeSentence'

  # 照片数据
  field :photos, type: Array, default: []

  # 体检大项结论
  field :conclusion

  default_scope -> { asc(:id) }
end