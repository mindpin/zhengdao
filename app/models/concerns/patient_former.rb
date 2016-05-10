module PatientFormer
  extend ActiveSupport::Concern

  included do

    former "Patient" do
      field :id, ->(instance) {instance.id.to_s}
      field :name
      field :gender
      field :gender_str, ->(instance) {
        {'MALE' => '男', 'FEMALE' => '女'}[instance.gender]
      }
      field :age
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

      field :current_status_info, ->(instance) {
        return '未在馆' if instance.active_record.blank?
        return PatientRecord.landing_statuses[instance.active_record.landing_status]
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
      field :reg_worker_id, ->(instance) {instance.reg_worker_id.to_s}
      field :next_visit_worker_id, ->(instance) {instance.next_visit_worker_id.to_s}
      field :attending_doctor_id, ->(instance) {instance.attending_doctor_id.to_s}
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
      field :next_visit_worker_info_str, ->(instance) {
        next_visit_worker = instance.next_visit_worker
        return '' if next_visit_worker.blank?
        return "接诊#{next_visit_worker.role_str}：#{next_visit_worker.name}"
      }

      field :common_update_url, ->(instance) {
        record_path(instance)
      }

      field :visit_url, ->(instance) {
        visit_record_path(instance)
      }

      # field :wizard_receive_url, ->(instance) {
      #   receive_wizard_record_path(instance)
      # }
      field :wizard_do_receive_url, ->(instance) {
        do_receive_wizard_record_path(instance)
      }

      # field :doctor_visit_url, ->(instance) {
      #   visit_doctor_record_path(instance)
      # }
      field :doctor_send_pe_url, ->(instance) {
        send_pe_doctor_record_path(instance)
      }
      field :doctor_send_cure_url, ->(instance) {
        send_cure_doctor_record_path(instance)
      }
      field :back_to_doctor_url, ->(instance) {
        back_to_doctor_record_path(instance)
      }

      logic :patient, ->(instance) {
        DataFormer.new(instance.patient).data
      }

      logic :first_visit, ->(instance) {
        instance.first_visit
      }
      logic :first_visit_conclusion, ->(instance) {
        instance.first_visit_conclusion
      }
      logic :cure_advice, ->(instance) {
        instance.cure_advice
      }
      logic :conclusion, ->(instance) {
        instance.conclusion
      }
      logic :pe_records, ->(instance) {
        instance.pe_records.map {|x|
          DataFormer.new(x).data
        }
      }
      logic :cure_records, ->(instance) {
        instance.cure_records.map {|x|
          DataFormer.new(x).data
        }
      }
    end

  end
end
