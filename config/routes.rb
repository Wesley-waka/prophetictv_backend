Rails.application.routes.draw do
  resources :admins
  resources :members
  resources :churches
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # post "/signup", to: "users#create"
  # post "/login", to: "sessions#create"
  # delete "/logout", to: "sessions#destroy"
  # get "/me", to: "users#show"

  post "/member/signup", to: "members#create"
  post "/member/login", to: "authentication#member_create"
  delete "/member/logout", to: "authentication#member_destroy"
  delete "/member/delete_account", to: "members#destroy"

  post "/admin/signup", to: "admins#create"
  post "/admin/login", to: "authentication#admin_create"
  delete "/admin/logout", to: "authentication#admin_destroy"
  delete "/admin/delete_account", to: "admins#destroy"
  # Defines the root path route ("/")
  # root "articles#index"
end
