Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/ui_kit", to: "pages#ui_kit"
end
