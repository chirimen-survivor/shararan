Rails.application.routes.draw do


  # 管理者用のルーティング
  devise_for :managers, :controllers => {
   :registrations => 'managers/registrations',
   :sessions => 'managers/sessions'
  }

  namespace :managers do
    resources :products, only: [:new, :show, :index]
    resources :customers, only: [:index, :show, :update, :destroy]
  end


  # ユーザー用のルーティング
  devise_for :customers
  root to: 'products#index'

  # その他の住所のルーティング
  resources :other_addresses

  # お問合せ用のルーティング
  resources :contacts


  get 'customers/sign_up' => 'devise/registrations#new'

  resources :products, only: [:show] do
  	resource :reviews, only: [:create]
  end


  resources :customers, only: [:show, :update, :destroy] do
  	get 'exit', on: :member

  	# レビュー用のルーティング
  	resource :reviews, only: [:create]

  	# 購入用のルーティング
  	resources :orders, only: [:new, :index, :show, :create] do
  		get 'select', on: :member
  		get 'complete', on: :member
  	end
  end
end
