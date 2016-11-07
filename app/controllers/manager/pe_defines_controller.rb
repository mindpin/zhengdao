class Manager::PeDefinesController < ApplicationController
  def index
    pe_defines = PeDefine.all.map{ |x|
      DataFormer.new(x).data
    }

    @component_name = 'manager_pe_defines'
    @component_data = {
      pe_defines: pe_defines,
      new_url: new_manager_pe_define_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '体检项目管理'
    }
  end

  def create
    pe_define = PeDefine.new pe_define_params
    save_model(pe_define) do |x|
      DataFormer.new(x)
        .data
    end
  end

  def update
    pe_define = PeDefine.find params[:id]
    update_model(pe_define, pe_define_params) do |x|
      DataFormer.new(x)
        .data
    end
  end

  def new
    @component_name = 'manager_pe_defines_new'

    @component_data = {
      submit_url: manager_pe_defines_path,
      cancel_url: manager_pe_defines_path,
    }
    @extend_nav_data = {
      mobile_back_to: manager_pe_defines_path,
      current_title: '新增体检项'
    }
  end

  def edit
    pe_define = PeDefine.find params[:id]

    @component_name = 'manager_pe_defines_edit'
    @component_data = {
      pe_define: DataFormer.new(pe_define).data,
      submit_url: manager_pe_define_path(pe_define),
      cancel_url: manager_pe_defines_path,
      vector_url: vector_manager_pe_define_path(pe_define),
    }
    @extend_nav_data = {
      mobile_back_to: manager_pe_defines_path,
      current_title: '修改体检项'
    }
  end

  def search_facts
    pe_define = PeDefine.find params[:id]

    if params[:q].blank?
      facts = []
    else
      facts = PeFact.where(name: /#{params[:q]}/)
    end

    data = facts.map {|fact|
      DataFormer.new(fact).data
    }
    render json: data
  end

  def vector
    pe_define = PeDefine.find params[:id]

    @extra_js = 'paper'
    @component_layout = 'VectorLayout'
    @component_name = 'manager_pe_define_vector'
    @component_data = {
      pe_define: DataFormer.new(pe_define).data,
      save_svg_url: save_svg_data_manager_pe_define_path(pe_define),
      savg_svg_areas_url: save_svg_areas_manager_pe_define_path(pe_define),
    }
  end

  def save_svg_data
    pe_define = PeDefine.find params[:id]
    pe_define.svg_data = params[:svg_data]
    pe_define.save
    render json: {}
  end

  def save_svg_areas
    pe_define = PeDefine.find params[:id]
    pe_define.svg_areas = JSON.parse params[:areas]
    pe_define.save
    render json: {}
  end

  private
  def pe_define_params
    params.require(:pe_define).permit(:name, :desc, fact_ids: [])
  end
end
