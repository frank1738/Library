Rails.application.routes.draw do
  resources :reservations
  resources :borrowings
  resources :books
  resources :categories
  resources :available_books
  devise_for :users
  root 'home#index'
  get 'borrow', to: 'home#borrow'
  get 'reserve', to: 'home#reserve'
  resources :users, only: %i[index destroy]
end
