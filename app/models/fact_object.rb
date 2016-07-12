class FactObject
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :fact_groups
end
