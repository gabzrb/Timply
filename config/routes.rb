Rails.application.routes.draw do
  get 'contact/new'
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'

  # get '/tracking', to: 'pages#tracking'
  # post '/trackingresult', to: 'pages#trackingresult'
  get '/mentionslegales', to: 'pages#mentionslegales'
  get '/conditionsgenerales', to: 'pages#conditionsgenerales'
  get '/apropos', to: 'pages#apropos'
  resources :contacts, only: [:new, :create]
  get :order_confirmation, to: 'orders#order_confirmation'
  resources :orders, only: [ :index, :destroy, :update, :edit ]
  resources :packs, only: [ :index, :show ] do
    resources :orders, only: [ :show, :create ] do
      resources :payments, only: [:new, :create]
    end
  end
  resources :carts, only: [:index]
end
