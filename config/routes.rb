Rails.application.routes.draw do
  root 'pages#index'
  get 'auth/:provider/callback' => 'sessions#create'
  get 'log_in' => 'sessions#new'
  post 'login' => 'sessions#login_to'

  delete 'log_out' => 'sessions#destroy'

  get 'sign_up' => 'users#new'

  resources :account_activations, only: [:edit]
  resources :users, except: [:new]
  resources :friend_ships, only: [:index]
  post "friend_request/:id" => "friend_ships#create", as: "friend_request"
  post "accept/:id" => "friend_ships#accept", as: "accept"
  post "block/:id" => "friend_ships#block", as: "block"
  post "unblock/:id" => "friend_ships#unblock", as: "unblock"
  delete "deny/:id" => "friend_ships#deny", as: "deny"
  delete "unfriend/:id" => "friend_ships#unfriend", as: "unfriend"

  # unfriend_sender_path
  # unfriend_receiver_path
end
