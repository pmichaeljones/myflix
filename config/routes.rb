Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home' => 'home#index'

  resources 'video'
end
