Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'home#index'

  mount ActionCable.server => '/cable'

  get ".well-known/assetlinks.json", to: "home#assetlinks"

  post "api/register", to: "users#create"
  get "api/qr_code", to: "users#qr_code"
  get "api/score", to: "users#score"
  get "api/rank", to: "users#rank"
  get "api/name", to: "users#name"
  get "api/scoreboard", to: "scoreboard#get_scoreboard"
  get "api/score_details", to: "scoreboard#get_score_details"

  get "api/*path", to: "home#not_found_api"

  # all path except api/* will be handled by home#index
  get "*path", to: "home#index"
end
