Rails.application.routes.draw do
  # kc mobile 2016 mockup
  get '/'      => 'index#index'
  get '/index' => 'index#index'

  get '/:page' => 'index#page', as: 'zhengdao'
end
