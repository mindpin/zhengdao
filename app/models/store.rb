class Store
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :location
  field :phone_number
  field :principal # 负责人
end
