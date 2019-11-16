Rails.application.routes.draw do

  devise_for :customers
  root to: 'products#index'
  # devise_scope :user do
  get 'customers/sign_up' => 'devise/registrations#new'

  resources :products, only: [:show] do
  	resource :reviews, only: [:create]
  end

  resources :orders, only: [:new, :index, :show] do
  	get 'create', on: :member

  	get 'select', on: :member

  	get 'complete', on: :member
  end


  resources :customers, only: [:show, :update, :destroy] do
  	resource :reviews, only: [:create]
  	get 'exit', on: :member
  end
end