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
      field :records_info_url, ->(instance) {
        records_info_wizard_patient_path(instance)
      }
      field :active_record_info_url, ->(instance) {
        active_record_info_wizard_patient_path(instance)
      }

      field :new_record_url, ->(instance) {
        new_wizard_patient_record_path(instance)
      }

      logic :records_count, ->(instance) {
        instance.patient_records.count
      }
      logic :records, ->(instance) {
        instance.patient_records.desc(:id).map {|x|
          DataFormer.new(x).data
        }
      }
      logic :active_record, ->(instance) {
        active_record = instance.active_record
        return nil if active_record.blank?
        return DataFormer.new(active_record).data
      }
    end

    former "PatientRecord" do
      field :id, ->(instance) {instance.id.to_s}
      field :reg_kind
      field :reg_date
      field :reg_period
      field :reg_worker_id
      field :reg_number
      field :landing_status

      field :reg_worker_name, ->(instance) {
        worker = instance.reg_worker
        return '未指定' if worker.blank?
        return worker.name
      }

      field :is_today, ->(instance) {
        instance.reg_date == Date.today
      }

      field :time_str, ->(instance) {
        instance.reg_date.strftime('%Y年%-m月%-d日')
      }
      field :time_weekday_str, ->(instance) {
        date = instance.reg_date
        wday = ['日', '一', '二', '三', '四', '五', '六'][date.wday]
        date.strftime("%Y年%-m月%-d日, 星期#{wday}")
      }
      field :period_str, ->(instance) {
        PatientRecord.reg_periods[instance.reg_period]
      }
      field :time_period_str, ->(instance) {
        s0 = instance.reg_date.strftime('%-m月%-d日')
        s1 = PatientRecord.reg_periods[instance.reg_period]
        "#{s0}#{s1}"
      }
      field :reg_kind_str, ->(instance) {
        PatientRecord.reg_kinds[instance.reg_kind]
      }
      field :reg_worker_str, ->(instance) {
        PatientRecord.reg_workers[instance.reg_kind]
      }
      field :landing_status_str, ->(instance) {
        PatientRecord.landing_statuses[instance.landing_status]
      }

      field :wizard_receive_url, ->(instance) {
        receive_wizard_record_path(instance)
      }

      logic :patient, ->(instance) {
        DataFormer.new(instance.patient).data
      }
    end

  end
end
