class PeFact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name # 特征名

  has_many :tags, class_name: 'PeTag', dependent: :destroy
  has_and_belongs_to_many :define, class_name: 'PeDefine'

  def tag_names
    self.tags.map(&:name)
  end

  def tag_names=(names)
    self.tags = names.map {|name|
      PeTag.create(name: name, fact: self)
    }
  end
end