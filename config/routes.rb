Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#connexion"
  get "home", to: "pages#home"

  patch 'geolocalize', to: 'pages#geolocalize'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :matches, only: [:index, :show] do
    resources :messages, only: [:create]
  end
  get "profil/:id", to: "pages#profil", as: "profil"
  get "availability", to: "pages#availability", as: "availability"
end
