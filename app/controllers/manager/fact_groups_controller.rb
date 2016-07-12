class Manager::FactGroupsController < ApplicationController
  layout 'manager'

  def index
    @page_name = 'manager_fact_groups'
    @component_data = {
      new_url: new_manager_fact_group_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '标签组管理'
    }
  end

  def new
    @page_name = 'manager_fact_groups_new'
    @component_data = {
      submit_url: manager_fact_groups_path,
      cancel_url: manager_fact_groups_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_fact_groups_path,
      current_title: '添加标签组'
    }
  end
end