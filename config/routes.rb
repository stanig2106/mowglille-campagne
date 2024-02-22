Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'home#index'

  mount ActionCable.server => '/cable'

  get ".well-known/assetlinks.json", to: "home#assetlinks"

  get "api/version", to: "home#version"

  post "api/notifications/subscribe", to: "notifications#subscribe"
  post "api/notifications/notify", to: "notifications#notify"
  post "api/notifications/update_status", to: "notifications#update_status"

  get "api/check_token", to: 'users#check_token'
  get "api/cla_login", to: "users#cla_login"
  post "api/register", to: "users#create"
  get "api/qr_code", to: "users#qr_code"
  get "api/check_qr_code/:content", to: "users#check_qr_code"
  get "api/users", to: "users#index"
  get "api/user", to: "users#show"
  get "api/score", to: "users#score"
  get "api/rank", to: "users#rank"
  get "api/name", to: "users#name"
  post "api/update_profile_picture", to: "users#update_profile_picture"
  post "bg-remover/:token", to: "users#bg_remover"

  get "api/scoreboard", to: "scoreboard#get_scoreboard"
  get "api/score_details", to: "scoreboard#get_score_details"

  get "api/staffers", to: "staffers#index"
  put "api/staffers/:public_token", to: "staffers#update"
  post "api/staff/offer", to: "staffers#offer"
  post "api/staff/reward", to: "staffers#reward"

  post "api/games/score", to: "games#save_score"
  get "api/games/scoreboard", to: "games#get_scoreboard"
  post "api/games/congratulate", to: "games#congratulate"

  get "api/events", to: "events#index"
  put "api/events/:internal_id", to: "events#update"
  get "api/current_event", to: "events#current_event"

  get "api/planning", to: "plannings#get_planning"
  post "api/update_planning_link", to: "plannings#update_planning_link"
  get "api/manage_planning", to: "plannings#manage_planning"
  post "api/planning_association", to: "plannings#set_planning_association"
  delete "api/planning_association", to: "plannings#delete_planning_association"

  get "api/*path", to: "home#not_found_api"

  # all path except api/* will be handled by home#index
  get '*path', to: 'home#index', constraints: ->(request) { !request.path.starts_with?('/rails') }
end
