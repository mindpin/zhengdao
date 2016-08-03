module FactGroupFormer
  extend ActiveSupport::Concern

  included do

    former "FactGroup" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :type, ->(instance) {
        'group'
      }

      field :edit_url, ->(instance) {
        edit_manager_fact_group_path(instance)
      }

      field :children, ->(instance) {
        instance.children.map do |fg|
          DataFormer.new(fg).data
        end
      }
      field :fact_tags, ->(instance) {
        instance.fact_tags.map do |ft|
          DataFormer.new(ft).data
        end
      }
    end
  end
end
