PassServiceExample::Application.routes.draw do
  get "sessions/new"

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  post 'callback', to: 'sessions#callback'

  resources :users

  root to: "sessions#new"
end
