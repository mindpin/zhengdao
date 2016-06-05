class PeRecordsController < ApplicationController
  layout 'manager'

  def new
    pe_define = PeDefine.find(params[:name])

    @page_name = 'pe_records_new'
    @component_data = {
      pe: {
        define: DataFormer.new(pe_define).data,
        record: {}
      },
      submit_url: pe_records_path,
      cancel_url: pe_records_path
    }
  end

  def edit
    pe_define = PeDefine.find(params[:name])

    @page_name = 'pe_records_new'
    @component_data = {
      pe: {
        define: DataFormer.new(pe_define).data,
        record: {
          a: ["123","345"]
        }
      },
      submit_url: pe_records_path,
      cancel_url: pe_records_path
    }
  end
end
