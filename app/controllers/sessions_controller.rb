class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, :only => :create, :if => :request_is_xhr
  def request_is_xhr
    request.xhr?
  end

  before_action :init_admin_user, only: :create
  def init_admin_user
    cond = {role: 'admin', name: 'admin', login: 'admin'}

    admin_user = User.where(cond).first
    
    if admin_user.blank?
      admin_user = User.new(cond)
      admin_user.password = params[:user][:password]
      admin_user.save
    end

    return true
  end

  def new
    case params[:role]
    when 'manager'
      manager_sign_in
    else
      common_user_sign_in
    end
  end

  private 
  def common_user_sign_in
    @page_name = 'auth_sign_in'
    @component_data = {
      common_sign_in_url: sign_in_path,
      common_submit_url: api_sign_in_path,

      manager_sign_in_url: sign_in_path(role: 'manager'),
      manager_submit_url: api_sign_in_path(role: 'manager')
    }
    render "/mockup/page", layout: 'auth'
  end

  def manager_sign_in
    @page_name = 'auth_manager_sign_in'
    @component_data = {
      common_sign_in_url: sign_in_path,
      common_submit_url: api_sign_in_path,

      manager_sign_in_url: sign_in_path(role: 'manager'),
      manager_submit_url: api_sign_in_path
    }
    render "/mockup/page", layout: "auth"
  end
end