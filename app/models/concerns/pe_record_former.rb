module PeRecordFormer
  extend ActiveSupport::Concern

  included do
    former "PeRecord" do
      field :id, ->(instance) {instance.id.to_s}
      field :name, ->(instance) {
        define = instance.pe_define
        define.blank? ? '' : define.name
      }
      field :conclusion

      field :edit_url, ->(instance) {
        edit_patient_pe_record_path(instance)
      }
      field :update_url, ->(instance) {
        patient_pe_record_path(instance)
      }
      field :sentences, ->(instance) {
        instance.sentences
      }
      field :new_sentence_url, ->(instance) {
        new_patient_pe_record_pe_sentence_path(instance)
      }
    end
  end
end