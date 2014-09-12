Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'home#index'

  resources 'video' do
    collection do
      get 'search', to: 'video#search'
    end
  end

  resources 'category'

  get '/login', to: 'session#login'

  get '/register', to: 'session#register'

end
