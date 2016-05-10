class PatientCureRecordsController < ApplicationController
  def update
    record = CureRecord.find params[:id]
    record.update_attributes record_params
    render json: DataFormer.new(record).data
  end

  def record_params
    params.require(:record).permit(
      :conclusion
    )
  end
end