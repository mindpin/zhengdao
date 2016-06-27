class RecordsController < ApplicationController
  def update
    record = PatientRecord.find params[:id]
    record.update_attributes record_params
    render json: DataFormer.new(record).data
  end

  def visit
    record = PatientRecord.find params[:id]

    if session[:current_role] == 'wizard'
      return redirect_to receive_wizard_record_path(record)
    end

    if session[:current_role] == 'doctor'
      return redirect_to visit_doctor_record_path(record)
    end

    if session[:current_role] == 'pe'
      return redirect_to visit_pe_record_path(record)
    end

    if session[:current_role] == 'cure'
      return redirect_to visit_cure_record_path(record)
    end
  end

  def reset
    record = PatientRecord.find params[:id]
    record.reset
    render json: {}
  end

  def cancel
    record = PatientRecord.find params[:id]
    record.cancel
    render json: {}
  end

  def record_params
    params.require(:record).permit(
      :first_visit, :first_visit_conclusion, :cure_advice,
      :conclusion
    )
  end
end