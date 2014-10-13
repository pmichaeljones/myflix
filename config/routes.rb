Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'home#index'

  resources :videos do
    collection do
      get '/search', to: 'videos#search'
    end

    resources :reviews, only: [:create]

  end

  resources :category

  resources :users

  resources :queue_items, only: [:create, :destroy, :update]
  post 'update_queue', to: 'queue_items#update_queue'

  resources :relationships, only: [:destroy, :create]

  #post '/relationships/:id', to: 'relationships#create'

  get '/people', to: 'relationships#index'

  get '/my_queue', to: 'queue_items#index'

  get '/register', to: 'users#new'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/log_out', to: 'sessions#destroy'

  get '/forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get 'reset_password'
end
