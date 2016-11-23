class PatientPeSentencesController < ApplicationController
  def new
    pe_record = PeRecord.find params[:patient_pe_record_id]
    pe_record_data = DataFormer.new(pe_record).data

    if params[:svg]
      @extra_js = 'paper'
      @component_layout = 'VectorLayout'
      @component_name = 'new_pe_sentence_svg'
    else
      @component_name = 'new_pe_sentence'
    end

    @component_data = {
      pe_define: DataFormer.new(pe_record.pe_define).data,
      submit_url: patient_pe_record_pe_sentences_path(patient_pe_record_id: pe_record.id),
      cancel_url: pe_record_data[:edit_url]
    }
  end

  def create
    data = JSON.parse params[:sentence_data_json]
    pe_record = PeRecord.find params[:patient_pe_record_id]

    pe_sentence = PeSentence.new({
      pe_record: pe_record,
      data: data
    })

    save_model(pe_sentence) do |_pe_sentence|
      DataFormer.new(_pe_sentence).data
    end
  end
end