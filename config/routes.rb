Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'home#index'
  get ".well-known/assetlinks.json", to: "home#assetlinks"
  get '*path', to: 'home#index'

  namespace :api do
    post "register", to: "users#create"
  end
end
