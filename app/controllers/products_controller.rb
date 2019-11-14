class ProductsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show]

  def index
  end

  def show
    @product = Product.find(params[:id])
  end
end
