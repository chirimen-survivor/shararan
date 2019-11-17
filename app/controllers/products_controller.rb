class ProductsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show]

  def index
    @products = Product.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page])
    @review = Review.new
  end

  def search_results
  end
end
