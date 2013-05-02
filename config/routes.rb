PassServiceExample::Application.routes.draw do
  get "sessions/new"

  post 'sessions/callback', to: 'sessions#callback'
  post 'users/callback', to: 'users#callback'

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root to: "sessions#new"
end
