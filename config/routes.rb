Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'
  get '/mentionslegales', to: 'pages#mentionslegales'
  get '/apropos', to: 'pages#apropos'
  resources :orders, only: [ :index, :destroy, :update, :edit ]
  resources :packs, only: [ :index, :show ] do
    resources :orders, only: [ :show, :new, :create ] do
      resources :payments, only: [:new, :create]
    end
  end
end
