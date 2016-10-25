class PatientPeSentencesController < ApplicationController
  def new
    pe_record = PeRecord.find params[:patient_pe_record_id]
    pe_record_data = DataFormer.new(pe_record).data

    @component_name = 'new_pe_sentence'
    @component_data = {
      pe_define: DataFormer.new(pe_record.pe_define).data,
      cancel_url: pe_record_data[:edit_url]
    }
  end
end