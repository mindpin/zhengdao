module PeFactFormer
  extend ActiveSupport::Concern

  included do
    former "PeFact" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :tag_names
      field :custom_tag_names
      field :is_area_fact

      field :edit_url, ->(instance) {
        edit_manager_pe_fact_path(instance)
      }
    end
  end
end