class PeFact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name # 特征名

  has_many :tags, class_name: 'PeTag', dependent: :destroy

  def tag_names
    self.tags.map(&:name)
  end

  def tag_names=(names)
    self.tags = names.map {|name|
      PeTag.create(name: name, fact: self)
    }
  end
end