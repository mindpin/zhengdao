class Wizard::RecordsController < ApplicationController
  layout 'manager'

  def new
    patient = Patient.find params[:patient_id]

    @page_name = 'wizard_patient_records_new'
    @component_data = {
    }
    @extend_nav_data = {
      mobile_back_to: wizard_patient_path(patient),
      current_title: "新增挂号：#{patient.name}"
    }
  end

  private

  def record_params
    params.require(:record)
  end
end