Rails.application.routes.draw do
  # kc mobile 2016 mockup
  get '/'      => 'index#index'
  get '/index' => 'index#index'
  get '/graph' => 'index#graph'

  get '/:page' => 'index#page', as: 'zhengdao'
end
