class CartItemsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :create, :destroy] # 後で消す

  def index

  end
end
