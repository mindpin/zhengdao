class IndexController < ApplicationController
  layout 'manager'

  def index
    if not user_signed_in?
      redirect_to sign_in_path
      return
    end

    role = (params[:role] || current_user.roles.first).to_sym
    session[:current_role] = role

    case role
    when :admin
      return redirect_to manager_path
    when :wizard
      return redirect_to wizard_path
    when :doctor
      return redirect_to doctor_path
    when :pe
      return redirect_to pe_path
    when :cure
      return redirect_to cure_path
    end

    @page_name = 'index'
    @component_data = {}
  end
end