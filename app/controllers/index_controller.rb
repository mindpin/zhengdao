class IndexController < ApplicationController
  def index
    if not user_signed_in?
      redirect_to sign_in_path
      return
    end
    
    if current_user.role == 'admin'
      redirect_to manager_path
      return
    end

    @page_name = 'index'
    @component_data = {}
  end
end