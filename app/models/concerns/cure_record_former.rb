module CureRecordFormer
  extend ActiveSupport::Concern

  included do
    former "CureRecord" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :conclusion
      field :response

      field :update_url, ->(instance) {
        patient_cure_record_path(instance)
      }
    end
  end
end