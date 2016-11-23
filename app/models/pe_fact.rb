class PeFact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name # 特征名
  field :is_area_fact, type: Boolean, default: false # 是否是区域特征（能被矢量图引用）

  has_many :tags, class_name: 'PeTag', dependent: :destroy
  has_and_belongs_to_many :define, class_name: 'PeDefine'
  has_many :custom_tags, class_name: 'PeCustomTag', dependent: :destroy

  def tag_names
    self.tags.map(&:name)
  end

  def tag_names=(names)
    self.tags = names.map {|name|
      PeTag.create(name: name, fact: self)
    }
  end

  def custom_tag_names
    self.custom_tags.map(&:name)
  end
end