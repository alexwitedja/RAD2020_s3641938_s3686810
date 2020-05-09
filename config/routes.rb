Rails.application.routes.draw do
  root 'users#new'
  get '/signup',   to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login',    to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'
  get '/home', to: 'static_pages#recent'
  get '/selected', to: 'static_pages#selected'
  post '/select', to: 'static_pages#select'
  resources :users, except: [:destroy, :index]
  resources :posts, except: [:edit, :index, :update, :destroy] do
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: :destroy
end