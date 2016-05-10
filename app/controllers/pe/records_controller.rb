class Pe::RecordsController < ApplicationController
  layout 'manager'

  def visit
    record = PatientRecord.find params[:id]
    patient = record.patient

    if record.pe_records.blank?
      %w{脉诊 三部九侯诊 舌诊 面诊 腹诊 背诊 脊柱诊 经络诊}.each { |name|
        record.pe_records.create(name: name)
      }
    end

    pe_records = record.pe_records.asc(:name).map {|x|
      DataFormer.new(x).data
    }

    @page_name = 'pe_patient_record_visit'
    @component_data = {
      patient: DataFormer.new(patient).data,
      record: DataFormer.new(record)
        .logic(:first_visit)
        .logic(:first_visit_conclusion)
        .logic(:conclusion)
        .logic(:pe_records)
        .logic(:cure_records)
        .data,
      pe_records: pe_records
    }
    @extend_nav_data = {
      mobile_back_to: pe_queue_path,
      current_title: "#{patient.name}"
    }
  end
end