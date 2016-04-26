class CustomFailure < Devise::FailureApp
  # 这个类的作用是当 controller 使用了
  # before_filter :authenticate_user!
  # 这个前置过滤器时
  # 如果发现没有登录时，跳转到那个页面
  def redirect_url
    "/sign_in"
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end