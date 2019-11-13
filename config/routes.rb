Rails.application.routes.draw do

  devise_for :customers
  root to: 'products#index'
  # devise_scope :user do
  get 'customers/sign_up' => 'devise/registrations#new'
  get 'customers/destroy' => 'customers#destroy'

  resources :products, only: [:show]
  resources :customers, only: [:show, :destroy]
end
