class Manager::PeFactsController < ApplicationController
  def index
    pe_facts = PeFact.all.map{ |x|
      DataFormer.new(x).data
    }

    @component_name = 'manager_pe_facts'
    @component_data = {
      pe_facts: pe_facts,
      new_url: new_manager_pe_fact_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '体检特征维护'
    }
  end

  def new
    @component_name = 'manager_pe_facts_new'

    @component_data = {
      submit_url: manager_pe_facts_path,
      cancel_url: manager_pe_facts_path,
    }
    @extend_nav_data = {
      mobile_back_to: manager_pe_facts_path,
      current_title: '新增体检特征'
    }
  end

  def create
    pe_fact = PeFact.new pe_fact_params
    p pe_fact_params
    save_model(pe_fact) do |x|
      DataFormer.new(x)
        .data
    end
  end

  def edit
    pe_fact = PeFact.find params[:id]

    @component_name = 'manager_pe_facts_edit'
    @component_data = {
      pe_fact: DataFormer.new(pe_fact).data,
      submit_url: manager_pe_fact_path(pe_fact),
      cancel_url: manager_pe_facts_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_pe_facts_path,
      current_title: '修改体检特征'
    }
  end

  def update
    pe_fact = PeFact.find params[:id]
    update_model(pe_fact, pe_fact_params) do |x|
      DataFormer.new(x)
        .data
    end
  end

  private

  def pe_fact_params
    params.require(:pe_fact).permit(:name, :is_area_fact, tag_names: [])
  end
end