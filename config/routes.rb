Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'
  resources :packs, only: [ :index, :show ] do
    resources :orders do
      resources :payments, only: [:new, :create]
    end
  end
end
