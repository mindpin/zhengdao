module FactTagFormer
  extend ActiveSupport::Concern

  included do

    former "FactTag" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
    end
  end
end
