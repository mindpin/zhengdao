class Manager::IndexController < ApplicationController
  layout 'manager'

  def index
    @page_name = 'manager_index'
    @component_data = {
      funcs: DataFormer.new(current_user).logic(:scenes).data()[:scenes].map {|x|
        x[:funcs]
      }.flatten
    }
    @extend_nav_data = {
      current_title: '总控面板'
    }
  end

  def sysinfo
    @page_name = 'manager_func_developing'
    @component_data = {}
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '系统信息'
    }
  end
end