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
  end
end
