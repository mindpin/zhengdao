class Manager::IndexController < ApplicationController
  layout 'manager'

  def index
    @page_name = 'manager_index'
    @component_data = {}
  end
end