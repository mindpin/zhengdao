class Store
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,     type: String
  field :location, type: String
end
