class Cure::IndexController < ApplicationController
  layout 'manager'

  def index
    funcs = DataFormer.new(current_user)
      .logic(:role_scenes)
      .data[:role_scenes]['cure']
      .map {|x|
        x[:funcs]
      }.flatten

    @page_name = 'cure_index'
    @component_data = {
      funcs: funcs,
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
      wait_queue_count: PatientRecord.cure_wait_queue(current_user).count,
      send_queue_count: PatientRecord.cure_send_queue(current_user).count,

      records: records.map {|x|
        DataFormer.new(x)
          .logic(:patient)
          .data
      },

      wait_queue_url: cure_queue_path(queue: 'wait'),
      send_queue_url: cure_queue_path(queue: 'send'),
    }
    @extend_nav_data = {
      mobile_back_to: cure_path,
      current_title: '患者队列处理'
    }
  end
end