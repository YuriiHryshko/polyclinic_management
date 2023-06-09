Rails.application.routes.draw do
  resources :patients
  resources :doctors, only: [:index, :show]
  resources :appointments, except: [:update] do
    resources :recommendations
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'pages#home'
  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
