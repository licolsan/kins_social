Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :users, except: [ :new, :create, :destroy ] do
    resources :channels, only: [ :show, :create ]
  end
  resources :posts, except: [ :new ] do
    resources :comments, only: [ :create ]
    resources :reacts, only: [ :create ]
    resources :reports, only: [ :create ]
  end
  resources :comments, only: [ :edit, :update, :destroy ] do
    resources :reacts, only: [ :create ]
  end
  resources :reacts, only: [ :edit, :update, :destroy ]
  resources :friend_ships, only: [:index]

  post "friend_request/:id" => "friend_ships#create", as: "friend_request"
  post "accept/:id" => "friend_ships#accept", as: "accept"
  post "block/:id" => "friend_ships#block", as: "block"
  post "unblock/:id" => "friend_ships#unblock", as: "unblock"
  delete "deny/:id" => "friend_ships#deny", as: "deny"
  delete "unfriend/:id" => "friend_ships#unfriend", as: "unfriend"

  post "follow/:id" => "follow_relationships#create", as: "follow"
  delete "unfollow/:id" => "follow_relationships#destroy", as: "unfollow"

  resources :messages, only: [ :create ]
  resources :channels, only: [ :new, :create, :show ]
  resources :groups do
    resources :member_ships, only: [ :new, :create, :destroy ]
  end

  resources :admins
  resources :reports, only: [ :index ]

  post "mark_remove/:id" => "posts#mark_remove", as: "mark_remove"
  post "unmark_remove/:id" => "posts#unmark_remove", as: "unmark_remove"
  post "lock_account/:id" => "users#lock", as: "lock_account"
  post "unlock_account/:id" => "users#unlock", as: "unlock_account"

  post "send_account_problem_noti/:id" => "admins#send_problem_email", as: "send_account_problem_noti"
  get "select_country/:id" => "users#select_country", as: "select_country"
end
