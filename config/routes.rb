Rails.application.routes.draw do
  get 'contact/new'
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'

  get '/mentionslegales', to: 'pages#mentionslegales'
  get '/conditionsgenerales', to: 'pages#conditionsgenerales'
  get '/apropos', to: 'pages#apropos'
  get '/nostarifs', to: 'pages#nostarifs'

  resources :contacts, only: [:new, :create]
  get :order_confirmation, to: 'orders#order_confirmation'
  resources :orders, only: [ :index, :destroy, :update, :edit ]
  resources :packs, only: [ :index, :show ] do
    resources :orders, only: [ :show, :create ] do
    end
  end
  resources :carts, only: [:show] do
    resources :payments, only: [:new, :create]
  end
end
