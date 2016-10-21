class Wizard::IndexController < ApplicationController
  layout 'manager'

  def index
    funcs = DataFormer.new(current_user)
      .logic(:role_scenes)
      .data[:role_scenes]['wizard']
      .map {|x|
        x[:funcs]
      }.flatten

    @component_name = 'wizard_index'
    @component_data = {
      funcs: funcs,
      search_url: wizard_search_path
    }
    @extend_nav_data = {
      current_title: '总控面板'
    }
  end

  def search
    query = params[:query]
    patients_data = Patient.or({name: /#{query}/}, {id_card: query}, {mobile_phone: query}).map {|p|
      DataFormer.new(p).data
    }
    @component_name = 'wizard_search'
    @component_data = {
      patients: patients_data,
      search_url: wizard_search_path,
      query: query
    }
    @extend_nav_data = {
      mobile_back_to: wizard_path,
      current_title: '患者查找'
    }
  end

  def queue
    queue = params[:queue] || 'reg'

    case queue
    when 'reg'
      records = PatientRecord.wizard_reg_queue
    when 'landing'
      records = PatientRecord.wizard_landing_queue
    when 'finish'
      records = PatientRecord.wizard_finish_queue
    end


    @component_name = 'wizard_queue'
    @component_data = {
      queue: queue,
      reg_queue_url: wizard_queue_path(queue: 'reg'),
      landing_queue_url: wizard_queue_path(queue: 'landing'),
      finish_queue_url: wizard_queue_path(queue: 'finish'),

      reg_queue_count: PatientRecord.wizard_reg_queue.count,
      landing_queue_count: PatientRecord.wizard_landing_queue.count,
      finish_queue_count: PatientRecord.wizard_finish_queue.count,

      records: records.map {|x|
        DataFormer.new(x)
          .logic(:patient)
          .data
      }
    }
    @extend_nav_data = {
      mobile_back_to: wizard_path,
      current_title: '导诊队列处理'
    }
  end
end