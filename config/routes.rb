Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'home#index'

  get '/home' => 'home#index'

  resources 'video' do
    collection do
      get 'search', to: 'video#search'
    end
  end

  resources 'category'
end
