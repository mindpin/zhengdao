class Pe::RecordsController < ApplicationController
  layout 'manager'

  def visit
    record = PatientRecord.find params[:id]
    patient = record.patient

    if record.pe_records.blank?
      PeDefine.all.each { |pe_define|
        record.pe_records.create(pe_define: pe_define)
      }
    end

    pe_records = record.pe_records.asc(:name).map {|x|
      DataFormer.new(x).data
    }

    @component_name = 'pe_patient_record_visit'
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