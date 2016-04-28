class Wizard::IndexController < ApplicationController
  layout 'manager'

  def index
    @page_name = 'wizard_index'
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

  def search
    query = params[:query]
    patients_data = Patient.or({name: /#{query}/}, {id_card: query}, {mobile_phone: query}).map {|p|
      DataFormer.new(p).data
    }
    @page_name = 'wizard_search'
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
end