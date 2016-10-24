class IndexController < ApplicationController
  def index
    if not user_signed_in?
      redirect_to sign_in_path
      return
    end

    # 检查传入角色是否可用
    params_role = params[:role]
    if not current_user.roles.include? params_role
      params_role = nil
    end

    # 获取当前角色
    role = params_role || current_user.last_used_role || current_user.roles.first

    current_user.update_attributes(last_used_role: role)
    session[:current_role] = role

    @component_name = 'RoleIndexPage'
    @component_data = {}
  end
end