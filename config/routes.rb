Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'home#index'

  resources :videos do
    collection do
      get '/search', to: 'videos#search'
    end
  end

  resources :category

  resources :users

  get '/sign_in', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
