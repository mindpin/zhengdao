module PatientFormer
  extend ActiveSupport::Concern

  included do

    former "Patient" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :id_card
      field :mobile_phone
      field :symptom_desc
      field :personal_pathography
      field :family_pathography

      field :wizard_show_url, ->(instance) {
        wizard_patient_path(instance)
      }
      field :records_url, ->(instance) {
        wizard_patient_records_path(instance)
      }
      field :new_record_url, ->(instance) {
        new_wizard_patient_record_path(instance)
      }
    end

    former "PatientRecord" do
      field :id, ->(instance) {instance.id.to_s}
      field :reg_kind
      field :reg_date
      field :reg_period
      field :worker_id

      field :worker, ->(instance) {
        User.where(id: instance.worker_id).first
      }

      field :time_str, ->(instance) {
        instance.reg_date.strftime('%Y年%-m月%-d日')
      }
      field :period_str, ->(instance) {
        PatientRecord.reg_periods[instance.reg_period]
      }
      field :reg_kind_str, ->(instance) {
        PatientRecord.reg_kinds[instance.reg_kind]
      }
      field :reg_worker_str, ->(instance) {
        PatientRecord.reg_kinds[instance.reg_kind]
      }
    end

  end
end
