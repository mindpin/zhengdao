class Manager::StoresController < ApplicationController
  layout 'manager'

  def index
    stores = Store.all.map{|x|
      DataFormer.new(x).data
    }

    @page_name = 'manager_stores'
    @component_data = {
      stores: stores,
      new_url: new_manager_store_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '店面管理'
    }
  end

  def new
    @page_name = 'manager_stores_new'
    @component_data = {
      submit_url: manager_stores_path,
      cancel_url: manager_stores_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_stores_path,
      current_title: '添加店面'
    }
  end

  def create
    store = Store.new store_params
    save_model(store) do |x|
      DataFormer.new(x)
        .data
    end
  end

  def edit
    store = Store.find params[:id]

    @page_name = 'manager_stores_edit'
    @component_data = {
      store: DataFormer.new(store).data,
      submit_url: manager_store_path(store),
      cancel_url: manager_stores_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_stores_path,
      current_title: '修改店面信息'
    }
  end

  def update
    store = Store.find params[:id]
    update_model(store, store_params) do |x|
      DataFormer.new(x)
        .data
    end
  end

  private

  def store_params
    params.require(:store).permit(:name, :location, :phone_number, :principal)
  end
end
