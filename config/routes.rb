Rails.application.routes.draw do

  root 'pages#index'
  get 'auth/:provider/callback' => 'sessions#create'
  get 'log_in' => 'sessions#new'
  post 'login' => 'sessions#login_to'

  delete 'log_out' => 'sessions#destroy'
  #get 'log_out' => 'sessions#destroy'

  get 'sign_up' => 'users#new'

  resources :account_activations, only: [:edit]
  resources :users, except: [:new]
  resources :friend_ships, only: [:index]
end
