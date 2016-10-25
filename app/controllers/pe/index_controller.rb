class Pe::IndexController < ApplicationController
  def queue
    queue = params[:queue] || 'wait'

    case queue
    when 'wait'
      records = PatientRecord.pe_wait_queue(current_user)
    when 'send'
      records = PatientRecord.pe_send_queue(current_user)
    end

    @component_name = 'pe_queue'
    @component_data = {
      queue: queue,
      wait_queue_count: PatientRecord.pe_wait_queue(current_user).count,
      send_queue_count: PatientRecord.pe_send_queue(current_user).count,

      records: records.map {|x|
        DataFormer.new(x)
          .logic(:patient)
          .data
      },

      wait_queue_url: pe_queue_path(queue: 'wait'),
      send_queue_url: pe_queue_path(queue: 'send'),
    }
    @extend_nav_data = {
      mobile_back_to: pe_path,
      current_title: '患者队列处理'
    }
  end
end