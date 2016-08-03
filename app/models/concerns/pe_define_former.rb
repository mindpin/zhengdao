module PeDefineFormer
  extend ActiveSupport::Concern

  included do

    former "PeDefine" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :desc

      field :edit_url, ->(instance) {
        edit_manager_pe_define_path(instance)
      }

      field :fact_groups, ->(instance) {
        if instance.fact_object.present?
          return instance.fact_object.fact_groups.map {|x|
            DataFormer.new(x).data
          }
        else
          return []
        end
      }
    end

  end
end
