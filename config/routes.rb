Rails.application.routes.draw do
  mount FilePartUpload::Engine => '/file_part_upload', :as => 'file_part_upload'

  get '/' => 'index#index', as: :root

  devise_for :users, :skip => :all
  devise_scope :user do
    get    "/sign_in"      => "sessions#new"
    post   "/api/sign_in"  => "sessions#create"
    delete "/api/sign_out" => "sessions#destroy"

    get    "/sign_up"      => "registrations#new"
    post   "/api/sign_up"  => "registrations#create"
  end

  namespace :manager do
    get '/' => 'index#index'
    get '/sysinfo' => 'index#sysinfo'
    get '/search/(:query)' => 'index#search', as: 'search'

    get '/business_graph' => 'index#business_graph', as: 'business_graph'
    get '/patient_graph' => 'index#patient_graph', as: 'patient_graph'
    get '/pe_demo' => 'index#pe_demo', as: 'pe_demo'

    resources :users
    resources :stores
    resources :pay_defines
    resources :pe_defines do
      get :search_facts, on: :member
      get :vector, on: :member
      put :save_svg_data, on: :member
    end

    # 体检记录相关
    resources :pe_facts

    resources :patients do
      get :records_info, on: :member
      get :active_record_info, on: :member

      resources :records, shallow: true do
        get :visit, on: :member
      end
    end
  end

  namespace :wizard do
    get '/' => 'index#index'
    get '/search/(:query)' => 'index#search', as: 'search'
    get 'queue' => 'index#queue'

    resources :patients do
      get :records_info, on: :member
      get :active_record_info, on: :member

      resources :records, shallow: true do
        get :receive, on: :member
        put :do_receive, on: :member
        get :visit, on: :member
      end
    end
  end

  namespace :doctor do
    get '/' => 'index#index'
    get 'queue' => 'index#queue'
    get 'calendar' => 'index#calendar'

    resources :records do
      get :visit, on: :member
      put :send_pe, on: :member
      put :send_cure, on: :member
      put :back_to, on: :member
      put :finish, on: :member
    end

    resources :activities
  end

  namespace :pe do
    get '/' => 'index#index'
    get 'queue' => 'index#queue'

    resources :records do
      get :visit, on: :member
    end
  end

  namespace :cure do
    get '/' => 'index#index'
    get 'queue' => 'index#queue'

    resources :records do
      get :visit, on: :member
    end
  end

  resources :records do
    get :visit, on: :member

    post :reset, on: :member
    post :cancel, on: :member
  end

  resources :patient_pe_records do
    put :update_photos, on: :member

    resources :pe_sentences, controller: 'patient_pe_sentences'
  end

  resources :patient_cure_records
end
