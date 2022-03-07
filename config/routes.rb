Rails.application.routes.draw do
  devise_for :users, except: [:show]
  root to: 'pages#home'
  resources :groups do
    resources :group_challenges, only: [:new, :create, :index, :show, :update]
    resources :memberships, only: [:create]
    resources :potential_challenges, only: [:create]
  end
  resources :users, only: :show
  get "/ui_kit", to: "pages#ui_kit"
  resources :challenges, only: [:index, :show, :new, :create]
  resources :potential_challenges, only: [] do
    resources :challenge_votes, only: [:create]
  end
  get "/my_dashboard", to: "users#show"
end
