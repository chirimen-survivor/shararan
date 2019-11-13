Rails.application.routes.draw do

  get 'reviews/create'
  devise_for :customers
  # devise_scope :user do
  get 'customers/sign_up' => 'devise/registrations#new'
end
