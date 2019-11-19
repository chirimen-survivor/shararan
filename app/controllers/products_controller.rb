class ProductsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show, :search_results]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page])
  end

  def show
    @review = Review.new
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page])
  end

  def search_results
    @q = Product.search(search_params)
    @products = @q.result(distinct: true).page(params[:page])
  end

  private

    def search_params
      params.require(:q).permit(:name_cont)
    end
end
