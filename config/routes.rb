Rails.application.routes.draw do
  # list and create recipes routes
  get '/recipes', to: 'recipes#index'
  post '/recipes', to: 'recipes#create'

  # routes for login and logout in sessions
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # route for signup and auto-login
  post '/signup', to: 'users#create'
  get '/me', to: 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
