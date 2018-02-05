Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :users, except: [:new]
  resources :posts, except: [:new]
  resources :friend_ships, only: [:index]
  post "friend_request/:id" => "friend_ships#create", as: "friend_request"
  post "accept/:id" => "friend_ships#accept", as: "accept"
  post "block/:id" => "friend_ships#block", as: "block"
  post "unblock/:id" => "friend_ships#unblock", as: "unblock"
  delete "deny/:id" => "friend_ships#deny", as: "deny"
  delete "unfriend/:id" => "friend_ships#unfriend", as: "unfriend"

  post "follow/:id" => "follow_relationships#create", as: "follow"
  delete "unfollow/:id" => "follow_relationships#destroy", as: "unfollow"

  get "select_country/:id" => "users#select_country", as: "select_country"
end
