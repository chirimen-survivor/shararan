class ProductsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show, :search_results]
  before_action :correct_customer, only: [:create]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page])
  end

  def show
    @review = Review.new
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page])
    @cart_item = CartItem.new(product_id: @product.id)
  end

  def create
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.new(cart_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.product_id = @product.id
    unless CartItem.exists?(product_id: @product.id)
      @cart_item.save!
      redirect_to customer_cart_items_path(@customer.id)
    else
      @cart_item = current_customer.cart_items.find_by(product_id: params[:product_id])
      @cart_item.update(cart_params)
      redirect_to customer_cart_items_path(@customer.id)
    end
  end

  def search_results
    @q = Product.search(search_params)
    @products = @q.result(distinct: true).page(params[:page])
  end
# 商品編集ページ
  # def edit
  #   @product = Product.find(params[:id])
  # end

  # def update
    
  # end
  # # 

  private

    def search_params
      params.require(:q).permit(:name_cont)
    end

    def cart_params
      params.require(:cart_item).permit(:product_id, :quantity)
    end

    # 正しいユーザーかどうか確認
    def correct_customer
      @customer = Customer.find_by(id: current_customer.id)
      if current_customer.id != @customer.id
        redirect_to root_path
      end
    end
end
