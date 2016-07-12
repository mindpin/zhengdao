class Manager::FactGroupsController < ApplicationController
  layout 'manager'

  def index
    fact_groups = FactGroup.all.map {|x|
      DataFormer.new(x).data
    }

    @page_name = 'manager_fact_groups'
    @component_data = {
      fact_groups: fact_groups,
      new_url: new_manager_fact_group_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '标签组管理'
    }
  end

  def list
    fact_groups = FactGroup.all.map {|x|
      DataFormer.new(x).data
    }

    if !params[:except_ids].blank?
      expect_fact_groups = FactGroup.find params[:except_ids]
      except_ids  = expect_fact_groups.map{|fg|fg.descendants_and_self}.flatten.map{|fg|fg.id.to_s}
      fact_groups = fact_groups.select{ |fg|
        !except_ids.include?(fg[:id])
      }
    end

    render json: fact_groups
  end

  def new
    @page_name = 'manager_fact_groups_new'
    @component_data = {
      submit_url: manager_fact_groups_path,
      cancel_url: manager_fact_groups_path,
      group_list_url: list_manager_fact_groups_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_fact_groups_path,
      current_title: '添加标签组'
    }
  end

  def create
    fact_group = FactGroup.new fact_group_params
    save_model(fact_group) do |x|
      DataFormer.new(x)
        .data
    end
  end

  def update
    fact_group = FactGroup.find params[:id]
    update_model(fact_group, fact_group_params) do |x|
      DataFormer.new(x)
        .data
    end
  end

  private

  def fact_group_params
    params.require(:fact_group).permit(:name, child_ids: [], tags: [])
  end
end
