Rails.application.routes.draw do

  devise_for :customers
  root to: 'products#index'
  # devise_scope :user do
  get 'customers/sign_up' => 'devise/registrations#new'

  resources :products, only: [:show]
  resources :customers, only: [:show, :update, :destroy] do
  	get 'exit', on: :member
  end

end
