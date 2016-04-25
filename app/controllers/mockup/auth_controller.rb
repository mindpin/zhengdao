class Mockup::AuthController < ApplicationController
  PAGE_AND_COMPONENT = {
    sign_in: %w{auth AuthSignInPage}
  }

  layout -> {
    page = params[:page].to_sym
    PAGE_AND_COMPONENT[page][0]
  }

  def page
    page = params[:page].to_sym
    @component_name = PAGE_AND_COMPONENT[page][1]
  end

  def do_post
    case params[:req].to_sym
    when :do_sign_in
      render json: {}
    end
  end
end