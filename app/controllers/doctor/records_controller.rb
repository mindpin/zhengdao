class Doctor::RecordsController < ApplicationController
  layout 'manager'

  def visit
    record = PatientRecord.find params[:id]
    patient = record.patient

    cure_items = PayDefine.all.map {|x|
      DataFormer.new(x).data
    }

    @page_name = 'doctor_patient_record_visit'
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
      mobile_back_to: doctor_queue_path,
      current_title: "#{patient.name}"
    }
  end

  def send_pe
    record = PatientRecord.find params[:id]

    if record.pe_records.blank?
      items = params[:selected_items]
      items.each do |name|
        record.pe_records.create(name: name)
      end
    end

    record.landing_status = 'WAIT_FOR_ASSIGN_PE'
    record.attending_doctor = current_user
    record.save

    render json: DataFormer.new(record)
      .logic(:first_visit)
      .logic(:first_visit_conclusion)
      .logic(:cure_advice)
      .logic(:conclusion)
      .data
  end

  def send_cure
    record = PatientRecord.find params[:id]

    if record.cure_records.blank?
      items = params[:selected_items]
      items.each do |name|
        record.cure_records.create(name: name)
      end
    end

    record.landing_status = 'WAIT_FOR_ASSIGN_CURE'
    record.attending_doctor = current_user
    record.save

    render json: DataFormer.new(record)
      .logic(:first_visit)
      .logic(:first_visit_conclusion)
      .logic(:cure_advice)
      .logic(:conclusion)
      .data
  end

  def back_to
    record = PatientRecord.find params[:id]

    if record.attending_doctor.present?
      record.landing_status = 'BACK_TO_DOCTOR'
      record.next_visit_worker = record.attending_doctor
      record.save
    else
      record.landing_status = 'FINISH'
      record.save
    end

    render json: DataFormer.new(record)
      .data
  end

  def finish
    record = PatientRecord.find params[:id]
    record.landing_status = 'FINISH'
    record.save
    render json: DataFormer.new(record)
      .data
  end
end