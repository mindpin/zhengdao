class PatientPeRecordsController < ApplicationController
  def edit
    pe_record = PeRecord.find params[:id]

    @component_name = 'pe_record_form'
    @component_data = {
      pe_record: DataFormer.new(pe_record).data,
      submit_url: "/patient_pe_records/#{pe_record.id}",
      cancel_url: "/pe/records/#{pe_record.patient_record.id}/visit"
    }
  end

  def show
    record = PeRecord.find params[:id]
    pe_define = record.pe_define

    saved_records = record.saved_records || []

    back_to_url =
      case session[:current_role].to_s
      when 'doctor'
        "/doctor/records/#{record.patient_record.id}/visit"
      when 'wizard'
        "/wizard/records/#{record.patient_record.id}/visit"
      when 'admin'
        "/manager/records/#{record.patient_record.id}/visit"
      end
      
    @component_name = 'pe_records_show'
    @component_data = {
      pe_name: pe_define.name,
      # records: DataFormer.new(pe_define)
      #   .logic(:merge_records, saved_records)
      #   .data[:merge_records],
      records: saved_records,
      submit_url: "/patient_pe_records/#{record.id}",
      cancel_url: back_to_url
    }


    @extend_nav_data = {
      mobile_back_to: back_to_url,
      current_title: "体检记录查看"
    }
  end

  # def update
  #   record = PeRecord.find params[:id]
  #   record.saved_records = params[:saved_records]
  #   record.save
  #   render json: DataFormer.new(record).data
  # end

  def update_photos
    pe_record = PeRecord.find params[:id]
    photos = JSON.parse params[:photos_data_json]
    pe_record.photos = photos
    pe_record.save

    render json: DataFormer.new(pe_record).data
  end
end