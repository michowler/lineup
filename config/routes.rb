Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  resources :users do
    resources :leaves
  end

  #api for mobile
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :users, only: [:index, :show]
    end
  end
  

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  root "pages#index"
  resources :leaves, controller: "leaves"
  get "/pending_leaves" => "leaves#pending"
  get "/leafe/approve/:id" => "leaves#approve"
  post "/leafe/reject/:id" => "leaves#reject"
  get "/leafe/details/:id" => "leaves#details"
  get "/hr/dashboard" => "hrs#dashboard"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
