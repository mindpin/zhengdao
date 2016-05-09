class RecordsController < ApplicationController
  def update
    record = PatientRecord.find params[:id]
    record.update_attributes record_params
    render json: DataFormer.new(record).data
  end

  def record_params
    params.require(:record).permit(
      :first_visit, :first_visit_conclusion, :cure_advice,
      :conclusion
    )
  end
end