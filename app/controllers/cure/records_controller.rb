class Cure::RecordsController < ApplicationController
  layout 'manager'

  def visit
    record = PatientRecord.find params[:id]
    patient = record.patient

    if record.cure_records.blank?
      PayDefine.all.map(&:name).each { |name|
        record.cure_records.create(name: name)
      }
    end

    cure_records = record.cure_records.map {|x|
      DataFormer.new(x).data
    }

    @component_name = 'cure_patient_record_visit'
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
      cure_records: cure_records
    }
    @extend_nav_data = {
      mobile_back_to: cure_queue_path,
      current_title: "#{patient.name}"
    }
  end
end