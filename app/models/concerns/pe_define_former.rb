module PeDefineFormer
  extend ActiveSupport::Concern

  included do
    former "PeDefine" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :desc
      field :facts, ->(instance) {
        instance.facts.map {|f|
          DataFormer.new(f).data
        }
      }

      field :edit_url, ->(instance) {
        edit_manager_pe_define_path(instance)
      }

      field :search_facts_url, ->(instance) {
        search_facts_manager_pe_define_path(instance)
      }
    end
  end
end
