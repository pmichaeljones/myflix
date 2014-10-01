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

  resources :queue_items, only: [:create, :destroy]

  get '/my_queue', to: 'queue_items#index'

  get '/register', to: 'users#new'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/log_out', to: 'sessions#destroy'

end
