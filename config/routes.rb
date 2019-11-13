Rails.application.routes.draw do

  get 'reviews/create'
  devise_for :customers
  # devise_scope :user do
  get 'customers/sign_up' => 'devise/registrations#new'
  get 'customers/destroy' => 'customers#destroy'
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: [:index, :show]
  resources :customers, only: [:show, :destroy]
end
