class Wizard::RecordsController < ApplicationController
  layout 'manager'

  def index
    records = current_patient.patient_records.desc(:id).map {|x|
      DataFormer.new(x).data
    }

    @page_name = 'wizard_patient_records'
    @component_data = {
      patient: DataFormer.new(current_patient).data,
      records: records
    }
    @extend_nav_data = {
      mobile_back_to: wizard_patients_path,
      current_title: "就诊记录：#{current_patient.name}"
    }
  end

  def new
    patient = Patient.find params[:patient_id]

    dates = [0, 1, 2, 3, 4, 5, 6].map {|x|
      # (Time.new + x.day).strftime('%-m月%-d日(星期%u)')
      Time.new + x.day
    }

    workers = User.where(:role.ne => 'admin').map {|x|
      DataFormer.new(x).data
    }

    @page_name = 'wizard_patient_records_new'
    @component_data = {
      reg_kinds: PatientRecord.reg_kinds,
      dates: dates,
      workers: workers,
      submit_url: wizard_patient_records_path(patient)
    }
    @extend_nav_data = {
      mobile_back_to: wizard_patient_path(patient),
      current_title: "新增挂号：#{patient.name}"
    }
  end

  def create
    patient = Patient.find params[:patient_id]

    record = patient.patient_records.new record_params
    record.save

    render json: DataFormer.new(record).data
  end

  private

  def current_patient
    Patient.find params[:patient_id]
  end

  def record_params
    params.require(:record).permit(:reg_kind, :reg_date, :reg_period, :worker_id)
  end
end