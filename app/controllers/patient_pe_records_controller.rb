class PatientPeRecordsController < ApplicationController
  layout 'manager'

  def edit
    record = PeRecord.find params[:id]

    name = record.name
    pe_define = PeDefine.find name

    saved_records = record.saved_records || []

    @page_name = 'pe_records_form'
    @component_data = {
      pe_name: name,
      records: DataFormer.new(pe_define)
        .logic(:merge_records, saved_records)
        .data[:merge_records],
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

    name = record.name
    pe_define = PeDefine.find name

    saved_records = record.saved_records || []

    @page_name = 'pe_records_show'
    @component_data = {
      pe_name: name,
      records: DataFormer.new(pe_define)
        .logic(:merge_records, saved_records)
        .data[:merge_records],
      submit_url: "/patient_pe_records/#{record.id}",
      cancel_url: "/doctor/records/#{record.patient_record.id}/visit"
    }

    @extend_nav_data = {
      mobile_back_to: "/doctor/records/#{record.patient_record.id}/visit",
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