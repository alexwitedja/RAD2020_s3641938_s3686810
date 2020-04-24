Rails.application.routes.draw do
  get 'users/new'
  root 'users#new'
  get '/signup',   to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end