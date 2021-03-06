Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :passwords, controller: "passwords", only: [:create, :new]
  get "/passwords/change" => "passwords#change"
  post "/passwords/update" => "passwords#update_password"
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]
  end

  resources :users do
    resources :leaves
  end
  get "/users/:id/pending" => "users#pending"
  get "/users/:id/upcoming" => "users#upcoming"
  get "/users/:id/history" => "users#history"

  #api for mobile
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :users, only: [:show]
      resources :leaves, only: [:create, :destroy]
      resources :total_leaves, only: [:total_leaves]
    end
  end
  

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  root "pages#index"
  get "/calendar" => "pages#calendar"
  resources :leaves, controller: "leaves"
  get "leaves/attachment/:id" => "leaves#attachment"
  get '/download/:id' => "leaves#download"
  get "hr/pending_leaves" => "leaves#pending"
  get "hr/upcoming_leaves" => "leaves#upcoming"
  get "/leafe/approve/:id" => "leaves#approve"
  post "/leafe/reject/:id" => "leaves#reject"
  get "/leafe/details/:id" => "leaves#details"
  get "/hr/dashboard" => "hrs#dashboard"
  get "/hr/statistics" => 'hrs#statistics'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '*path' => redirect('/'), via: :get unless Rails.env.development?
end
