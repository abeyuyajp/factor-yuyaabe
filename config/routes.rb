Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
  resources :posts
  resources :users, only: :show
  resources :rooms, only: [:index, :create, :show] 
  resources :messages, only: :create
end
