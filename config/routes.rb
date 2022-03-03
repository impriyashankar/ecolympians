Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :groups
  resources :users, only: :show
  get "/ui_kit", to: "pages#ui_kit"
  resources :challenges, only: [:index, :show, :new, :create]
end
