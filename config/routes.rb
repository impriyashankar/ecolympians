Rails.application.routes.draw do
  devise_for :users, except: [:show]
  root to: 'pages#home'
  resources :groups do
    resources :group_challenges, only: [:new, :create, :index, :show]
    resources :memberships, only: [:new, :create, :index, :show]
  end
  resources :users, only: :show
  get "/ui_kit", to: "pages#ui_kit"
  resources :challenges, only: [:index, :show, :new, :create]

  resources :group_challenges, only: [:show, :create]
  get "/my_dashboard", to: "users#show"
end
