Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home' => 'home#index'

  get '/search' => 'search#input'

  resources 'video'

  resources 'category'
end
