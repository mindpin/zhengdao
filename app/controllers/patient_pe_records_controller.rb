class PatientPeRecordsController < ApplicationController
  layout 'manager'

  def edit
    record = PeRecord.find params[:id]
    pe_define = record.pe_define

    saved_records = record.saved_records || []

    @page_name = 'pe_records_form'
    @component_data = {
      pe_name: pe_define.name,
      records: [],
      fact_object: DataFormer.new(pe_define.fact_object).data,
      submit_url: "/patient_pe_records/#{record.id}",
      cancel_url: "/pe/records/#{record.patient_record.id}/visit"
    }

    @extend_nav_data = {
      mobile_back_to: "/pe/records/#{record.patient_record.id}/visit",
      current_title: "体检录入"
    }

    # render json: @component_data
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
      
    @page_name = 'pe_records_show'
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

  def update
    record = PeRecord.find params[:id]
    record.saved_records = params[:saved_records]
    record.save
    render json: DataFormer.new(record).data
  end

end