Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "homepages#index"
  
  resources :works
  # post "/upvote", to: "votes#upvote", as: "upvote"
  # resources :votes, only: [:create]
  
  
  get "/users", to: "users#index", as: "users"
  get "/users/:id", to: "users#show", as: "user"
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  
  # post "/works/:id/upvote", to: "votes#upvote", as: "new_vote"
  
  post "/works/:id/upvote", to: "works#upvote", as: "upvote"
end
