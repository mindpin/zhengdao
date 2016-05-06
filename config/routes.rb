Rails.application.routes.draw do
  get '/' => 'index#index', as: :root

  devise_for :users, :skip => :all
  devise_scope :user do
    get    "/sign_in"      => "sessions#new"
    post   "/api/sign_in"  => "sessions#create"
    delete "/api/sign_out" => "sessions#destroy"

    get    "/sign_up"      => "registrations#new"
    post   "/api/sign_up"  => "registrations#create"
  end

  # get '/index' => 'mockup/index#index'
  # get '/graph' => 'mockup/index#graph'

  # get '/:page' => 'mockup/index#page', as: 'zhengdao'

  namespace :manager do
    get '/' => 'index#index'
    get '/sysinfo' => 'index#sysinfo'

    resources :users
    resources :stores
    resources :pay_defines
  end

  namespace :wizard do
    get '/' => 'index#index'
    get "/search/(:query)" => 'index#search', as: 'search'

    resources :patients do
      resources :records
    end
  end
  resources :pe_records
end
