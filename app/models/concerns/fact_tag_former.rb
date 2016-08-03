module FactTagFormer
  extend ActiveSupport::Concern

  included do

    former "FactTag" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :type, ->(instance) {
        'tag'
      }
    end
  end
end
