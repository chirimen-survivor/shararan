Rails.application.routes.draw do

  devise_for :customers
  # devise_scope :user do
  get 'customers/sign_up' => 'devise/registrations#new'
  resources :products, only: [:show]
end
