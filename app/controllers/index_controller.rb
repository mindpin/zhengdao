class IndexController < ApplicationController
  def index
    if not user_signed_in?
      redirect_to sign_in_path
      return
    end

    # 获取当前角色
    role = (params[:role] || current_user.roles.first).to_sym
    session[:current_role] = role

    case role
    when :doctor
      return redirect_to doctor_queue_path
    when :pe
      return redirect_to pe_queue_path
    when :cure
      return redirect_to cure_queue_path
    end

    @component_name = 'RoleIndexPage'
    @component_data = {}
  end
end