Rails.application.routes.draw do

  get 'manager_orders/index'
  get 'manager_orders/show'
  # 管理者用のルーティング
  devise_for :managers, :controllers => {
   :registrations => 'managers/registrations',
   :sessions => 'managers/sessions'
  }

  namespace :managers do
    resources :products, only: [:new, :create, :show, :index]
    resources :customers, only: [:index, :show, :update, :destroy]
    resources :contacts, only: [:index,:show, :update]
    resources :accs, only: [:new, :create, :edit, :update, :destroy]
  end


  # ユーザー用のルーティング
  devise_for :customers
  root to: 'products#index'

  # その他の住所のルーティング
  resources :other_addresses


  get 'customers/sign_up' => 'devise/registrations#new'

  resources :products, only: [:show] do
  	resource :reviews, only: [:create]
    resource :favorites, only: [:create, :destroy]
    resource :cart_items, only: [:destroy]
  end

  # 検索結果のルート

  get 'search', to: 'products#search_results'
  post 'products/:product_id/cart_items', to: 'products#create'


  resources :customers, only: [:show, :update, :destroy] do
  	get 'exit', on: :member

  	# レビュー用のルーティング
    resource :reviews, only: [:create]
    resources :cart_items, only: [:index]


  	# 購入用のルーティング
  	resources :orders, only: [:new, :index, :show, :create] do
  		get 'select', on: :member
  		get 'complete', on: :member
  	end


    resources :contacts, only: [:show, :create]

    resources :favorites, only: [:index]

  end

  # letter_openerを表示させるためのルーティング
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
