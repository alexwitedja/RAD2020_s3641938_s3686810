Rails.application.routes.draw do
  get 'settings/setting'
  root 'users#new'
  get '/signup',   to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login',    to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'
  get '/home', to: 'static_pages#recent'
  get '/selected', to: 'static_pages#selected'
  post '/select', to: 'static_pages#select'
  get '/settings/profile', to: 'settings#profile'
  get '/settings/posts', to: 'settings#posts'
  get '/settings/comments', to: 'settings#comments'
  get '/settings/receivedcomments', to: 'settings#receivedcomments'
  get '/users/:id/edit_pass', to: 'users#edit_pass', as: :edit_pass
  patch '/users/:id/edit_pass', to: 'users#update_pass', as: :update_pass
  get '/users/:id/edit_avatar', to: 'users#edit_avatar', as: :edit_avatar
  patch '/users/:id/update_avatar', to: 'users#update_avatar', as: :update_avatar
  get '/users/:id/edit_card', to: 'users#edit_card', as: :edit_card
  patch '/users/:id/update_card', to: 'users#update_card', as: :update_card
  
  resources :users, except: [:destroy, :index] do
    resources :verifications, only: [:update, :edit]
  end
  resources :posts, except: [:edit, :index, :update, :destroy] do
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: :destroy
end