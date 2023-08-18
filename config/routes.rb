Rails.application.routes.draw do
  # resources :sermons
  resources :appointments
  resources :prayers
  # resources :admins
  # resources :members
  resources :churches
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # post "/signup", to: "users#create"
  # post "/login", to: "sessions#create"
  # delete "/logout", to: "sessions#destroy"
  # get "/me", to: "users#show"
  resources :sermons, only: [ :new, :create,:index] do
    get 'download', on: :member # GET /videos GET /videos/:id/download GET /videos/new POST /videos 
  end
  # root 'videos#index'
  # get '/videos/all', to: 'videos#index'

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
