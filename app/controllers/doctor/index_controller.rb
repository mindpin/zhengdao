class Doctor::IndexController < ApplicationController
  layout 'manager'

  def index
    @page_name = 'doctor_index'
    @component_data = {
      funcs: DataFormer.new(current_user).logic(:scenes).data()[:scenes].map {|x|
        x[:funcs]
      }.flatten,
      search_url: wizard_search_path
    }
    @extend_nav_data = {
      current_title: '总控面板'
    }
  end

  def queue
    records = PatientRecord.wait_of_doctor(current_user)

    @page_name = 'doctor_queue'
    @component_data = {
      queue: params[:queue],
      records: records.map {|x|
        DataFormer.new(x)
          .logic(:patient)
          .data
      },
      default_queue_url: doctor_queue_path,
      pe_queue_url: doctor_queue_path(queue: 'pe'),
      cure_queue_url: doctor_queue_path(queue: 'cure'),
    }
    @extend_nav_data = {
      mobile_back_to: doctor_path,
      current_title: '患者队列处理'
    }
  end
end