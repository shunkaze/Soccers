Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :players, only: [:new, :create, :index, :edit, :show, :update, :destroy]
  resources :teams, only: [:new, :create, :index, :edit, :show, :update, :destroy]
end
