class Manager::UsersController < ApplicationController
  layout 'manager'

  def index
    users = User.without_role(:admin).map {|x|
      DataFormer.new(x).data
    }

    @page_name = 'manager_users'
    @component_data = {
      users: users,
      new_url: new_manager_user_path
    }
    @extend_nav_data = {
      mobile_back_to: manager_path,
      current_title: '人员管理'
    }
  end

  def new
    stores = Store.all.map {|x|
      DataFormer.new(x).data
    }
    @page_name = 'manager_users_new'
    @component_data = {
      submit_url: manager_users_path,
      cancel_url: manager_users_path,
      stores: stores
    }
    @extend_nav_data = {
      mobile_back_to: manager_users_path,
      current_title: '添加人员'
    }
  end

  def create
    user = User.new user_params
    user.roles = params[:user][:roles]
    save_model(user) do |_user|
      DataFormer.new(_user)
        .data
    end
  end

  def edit
    user = User.find params[:id]
    stores = Store.all.map {|x|
      DataFormer.new(x).data
    }
    @page_name = 'manager_users_edit'
    @component_data = {
      user: DataFormer.new(user).data,
      submit_url: manager_user_path(user),
      cancel_url: manager_users_path,
      stores: stores
    }
    @extend_nav_data = {
      mobile_back_to: manager_users_path,
      current_title: '修改人员信息'
    }
  end

  def update
    user = User.find params[:id]
    user.roles = params[:user][:roles]
    update_model(user, user_params) do |_user|
      DataFormer.new(_user)
        .data
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :login, :roles, :password, :store_id)
  end
end
