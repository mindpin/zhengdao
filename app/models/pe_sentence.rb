class PeSentence
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :pe_record

  field :data, type: Array, default: []

  default_scope -> { asc(:id) }
end