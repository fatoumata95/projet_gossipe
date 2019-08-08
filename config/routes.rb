Rails.application.routes.draw do
resources :gossips
resources :users
resources :sessions, only: [:new, :create, :destroy]
end