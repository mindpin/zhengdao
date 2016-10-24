class PeRecordsController < ApplicationController
  def new
    pe_define = PeDefine.find(params[:name])

    @component_name = 'pe_records_form'
    @component_data = {
      records: DataFormer.new(pe_define)
        .logic(:merge_records, nil)
        .data[:merge_records],
      submit_url: pe_records_path,
      cancel_url: pe_records_path
    }
  end

  def edit
    pe_define = PeDefine.find(params[:name])

    records = [
      {
        label: 'aaa',
        values: ['123', '456']
      }
    ]

    @component_name = 'pe_records_form'
    @component_data = {
      records: DataFormer.new(pe_define)
        .logic(:merge_records, records)
        .data[:merge_records],
      submit_url: pe_records_path,
      cancel_url: pe_records_path
    }
  end
end
