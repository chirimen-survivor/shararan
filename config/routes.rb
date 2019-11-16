Rails.application.routes.draw do

  # devise_for :managers
  devise_for :customers
  root to: 'products#index'

  devise_for :managers, :controllers => {
   :registrations => 'managers/registrations',
   :sessions => 'managers/sessions'
  }

    # devise_scope :manager do
    #   get "managers/sign_in", :to => "manager/sessions#new"
    #   get "managers/sign_out", :to => "manager/sessions#destroy" 
    # end



  get 'customers/sign_up' => 'devise/registrations#new'

  resources :products, only: [:show]

  resources :orders, only: [:new, :index, :show] do
  	get 'create', on: :member

  	get 'select', on: :member

  	get 'complete', on: :member
  end


  resources :customers, only: [:show, :update, :destroy] do
  	get 'exit', on: :member
  end
end