Rails.application.routes.draw do


  # 管理者用のルーティング
  devise_for :managers, :controllers => {
   :registrations => 'managers/registrations',
   :sessions => 'managers/sessions'
  }

  namespace :managers do
    resources :products, only: [:new, :show, :index]
  end


  # ユーザー用のルーティング
  devise_for :customers
  root to: 'products#index'



  get 'customers/sign_up' => 'devise/registrations#new'

  resources :products, only: [:show] do
  	resource :reviews, only: [:create]
  end

  # 購入用のルーティング
  # resources :orders, only: [:new, :index, :show] do
  # 	get 'create', on: :member

  # 	get 'select', on: :member

  # 	get 'complete', on: :member
  # end


  resources :customers, only: [:show, :update, :destroy] do
  	get 'exit', on: :member
  	resource :reviews, only: [:create]
  	resources :orders, only: [:new, :index, :show, :create] do
  		get 'select', on: :member
  		get 'complete', on: :member
  	end
  end
end
