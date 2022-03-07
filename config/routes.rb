Rails.application.routes.draw do
  devise_for :users, except: [:show]
  root to: 'pages#home'
  resources :groups do
    resources :group_challenges, only: [:new, :create, :index, :show, :update]
    resources :potential_challenges, only: [:create]
    resources :memberships, except: [:new, :show] do
      member do
        patch :update_status
      end
    end
  end
  resources :users, only: :show
  get "/ui_kit", to: "pages#ui_kit"
  resources :challenges, only: [:index, :show, :new, :create]
  resources :potential_challenges, only: [] do
    resources :challenge_votes, only: [:create]
  end
  get "/my_dashboard", to: "users#show"

  resources :group_challenges, only: [] do
    resources :proof_votes, only: [:create]
  end
end
