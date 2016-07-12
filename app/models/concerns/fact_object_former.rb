module FactObjectFormer
  extend ActiveSupport::Concern

  included do

    former "FactObject" do
      field :id, ->(instance) {instance.id.to_s}

      field :children, ->(instance) {
        instance.fact_groups.map do |fact_group|
          DataFormer.new(fact_group).data
        end
      }
    end
  end
end
