module PeAndCureRecordFormer
  extend ActiveSupport::Concern

  included do

    former "PeRecord" do
      field :id, ->(instance) {instance.id.to_s}
      field :name, ->(instance) {
        instance.pe_define.name
      }
      field :conclusion

      field :edit_url, ->(instance) {
        edit_patient_pe_record_path(instance)
      }
      field :update_url, ->(instance) {
        patient_pe_record_path(instance)
      }
    end

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