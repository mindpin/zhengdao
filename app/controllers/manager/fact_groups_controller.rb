class Manager::FactGroupsController < ApplicationController
  layout 'manager'

  def index
    @page_name = 'manager_fact_groups'
    @component_data = {
      a: 1
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '标签组管理'
    }
  end
end