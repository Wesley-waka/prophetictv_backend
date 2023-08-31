Rails.application.routes.draw do
  # resources :sermons
  resources :appointments, only: [:index, :new, :create, :show]
  resources :prayers, only: [:index, :new, :create, :show]

  # resources :admins
  # resources :members
  resources :churches
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # post "/signup", to: "users#create"
  # post "/login", to: "sessions#create"
  # delete "/logout", to: "sessions#destroy"
  # get "/me", to: "users#show"
  resources :videos, only: [ :new, :create, :show] do
    get 'download', on: :member
  end
  # root 'videos#index'
  get '/videos', to: 'videos#index'
  get '/videos/:id', to: 'videos#show'
  post '/prayers/create', to: 'prayers#create'
  post '/appointments/create', to: 'appointments#create'

  post "/superadmin/login", to: "master_sessions#create"
  post "/superadmin/signup", to: "masters#create"


  post "/member/signup", to: "members#create"
  post "/member/login", to: "member_sessions#create"
  delete "/member/logout", to: "member_sessions#destroy"

  post "/admin/signup", to: "admins#create"
  post "/admin/login", to: "admin_sessions#create"
  delete "/admin/logout", to: "admin_sessions#destroy"
  delete "/admin/delete_account", to: "admins#destroy"
  # Defines the root path route ("/")
  # root "articles#index"
end
