module PeAndCureRecordFormer
  extend ActiveSupport::Concern

  included do

    former "PeRecord" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :conclusion
    end

    former "CureRecord" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :conclusion
      field :response
    end

  end

end