class PeDefine
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name # 体检项名称
  field :desc # 描述

  field :svg_data # svg 文件信息

  has_and_belongs_to_many :facts, class_name: 'PeFact'

  def fact_names
    self.facts.map(&:name)
  end
end