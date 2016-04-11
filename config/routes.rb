Rails.application.routes.draw do
  # kc mobile 2016 mockup
  get '/'      => 'mockup/index#index'
  get '/index' => 'mockup/index#index'
  get '/graph' => 'mockup/index#graph'

  get '/:page' => 'mockup/index#page', as: 'zhengdao'

  # 登录验证
  get '/auth/:page' => 'mockup/auth#page', as: 'auth'
  post '/auth/:req' => 'mockup/auth#do_post', as: 'post_auth'
end
