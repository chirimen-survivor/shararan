class ProductsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show]

  def index
    @products = Product.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search_results
  end
end
