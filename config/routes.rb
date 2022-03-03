Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :groups
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/ui_kit", to: "pages#ui_kit"
  resources :challenges, only: [:index, :show, :new, :create]

  resources :group_challenges, only: [:show, :create]
end
