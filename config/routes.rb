Rails.application.routes.draw do
  resources :reservations
  resources :borrowings
  resources :books
  resources :categories
  devise_for :users
  root 'home#index'
end
