class Wizard::RecordsController < ApplicationController
  layout 'manager'

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

    render json: {
      record: DataFormer.new(record).data,
      active_record_info_url: active_record_info_wizard_patient_path(patient)
    }
  end

  def receive
    record = PatientRecord.find params[:id]
    patient = record.patient

    constraint_workers = record.constraint_workers(current_user) || []

    @page_name = 'wizard_patient_record_receive'
    @component_data = {
      patient: DataFormer.new(patient).data,
      record: DataFormer.new(record).data,
      constraint_workers: constraint_workers.map {|x|
        DataFormer.new(x).data
      },
    }
    @extend_nav_data = {
      mobile_back_to: wizard_queue_path,
      current_title: "导诊处理：#{patient.name}"
    }
  end

  def do_receive
    record = PatientRecord.find params[:id]
    if record.landing_status == 'FINISH'
      record.go_away
    else
      record.assign_visit_worker params[:next_visit_worker_id]
    end
    render json: DataFormer.new(record).data
  end

  def visit
    record = PatientRecord.find params[:id]
    patient = record.patient

    cure_items = PayDefine.all.map {|x|
      DataFormer.new(x).data
    }

    @page_name = 'wizard_patient_record_visit'
    @component_data = {
      patient: DataFormer.new(patient).data,
      record: DataFormer.new(record)
        .logic(:first_visit)
        .logic(:first_visit_conclusion)
        .logic(:cure_advice)
        .logic(:conclusion)
        .logic(:pe_records)
        .logic(:cure_records)
        .data,
      cure_items: cure_items
    }
    @extend_nav_data = {
      mobile_back_to: records_info_wizard_patient_path(patient),
      current_title: "#{patient.name}"
    }
  end

  private

  def current_patient
    Patient.find params[:patient_id]
  end

  def record_params
    params.require(:record).permit(:reg_kind, :reg_date, :reg_period, :reg_worker_id)
  end
end