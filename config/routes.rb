Myflix::Application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'

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

  resources :password_resets, only: [:show, :create]

  get 'expired_token', to: 'password_resets#expired'

  resources :invitations, only: [:new, :create]
  get '/register/:token', to: "users#new_with_invitation_token", as: 'register_with_token'


end
