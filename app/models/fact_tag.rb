class FactTag
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  belongs_to :fact_group

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :fact_group_id, if: ->(t){!t.fact_group_id.blank?}
end
