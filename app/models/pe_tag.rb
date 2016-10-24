class PeTag
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name # 标签名（作为特征值）

  belongs_to :fact, class_name: 'PeFact'
end