class Mockup::AuthController < ApplicationController
  layout -> {
    'auth'
  }

  def page
    page = params[:page].to_sym
    @component_name = 'AuthSignInPage'
    @component_data = {
      
    }
  end

  def do_post
    case params[:req].to_sym
    when :do_sign_in
      render json: {}
    end
  end
end