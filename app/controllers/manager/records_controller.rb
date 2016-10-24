class Manager::RecordsController < ApplicationController
  def visit
    record = PatientRecord.find params[:id]
    patient = record.patient

    cure_items = PayDefine.all.map {|x|
      DataFormer.new(x).data
    }

    @component_name = 'wizard_patient_record_visit'
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
      mobile_back_to: records_info_manager_patient_path(patient),
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