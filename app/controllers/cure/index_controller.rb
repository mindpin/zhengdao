class Cure::IndexController < ApplicationController
  layout 'manager'

  def index
    @page_name = 'cure_index'
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
    queue = params[:queue] || 'wait'

    case queue
    when 'wait'
      records = PatientRecord.cure_wait_queue(current_user)
    when 'send'
      records = PatientRecord.cure_send_queue(current_user)
    end

    @page_name = 'cure_queue'
    @component_data = {
      queue: queue,
      # wait_queue_count: PatientRecord.doctor_wait_queue(current_user).count,
      # send_pe_queue_count: PatientRecord.doctor_send_pe_queue(current_user).count,
      # send_cure_queue_count: PatientRecord.doctor_send_cure_queue(current_user).count,

      # records: records.map {|x|
      #   DataFormer.new(x)
      #     .logic(:patient)
      #     .data
      # },


      # default_queue_url: doctor_queue_path(queue: 'wait'),
      # pe_queue_url: doctor_queue_path(queue: 'pe'),
      # cure_queue_url: doctor_queue_path(queue: 'cure'),
    }
    @extend_nav_data = {
      mobile_back_to: cure_path,
      current_title: '患者队列处理'
    }
  end
end