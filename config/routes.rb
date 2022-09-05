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
  resources :user do
    resources :preferences, only: [:edit, :new, :update, :create]
    get "preferences", to: "preferences#show", as: "show_preference"
  end

  get "profil/:id", to: "pages#profil", as: "profil"
  get "availability", to: "pages#availability", as: "availability"
  get "home/:id", to: "pages#match?", as: "new_match_or_match_favorable"
  get "home/nomatch/:id", to: "pages#no", as: "no_match"
  # get "home", to: "pages#connexion", as: "entry_page"
end
