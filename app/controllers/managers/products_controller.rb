class Managers::ProductsController < Managers::ApplicationController
skip_before_action :authenticate_customer!, only: [:index, :show, :new, :create]


  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to 'show'
  end

  def index
  end

  def show
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :image, :release_date, :status, :description, :artist_id, :category_id, :company_id,)
  end
end
