class ProductsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show, :search_results]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page])
    @all_ranks = Product.find(Favorite.group(:product_id).order('count(product_id) desc').limit(3).pluck(:product_id))
  end

  def show
    @review = Review.new
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page])
    @cart_item = CartItem.new(product_id: @product.id)
    @discs = @product.discs.all.order(sequence: 'ASC')
  end

  # カートに入れる
  def create
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.new(cart_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.product_id = @product.id
    unless CartItem.where(product_id: @product.id).where(customer_id: current_customer.id).exists?
      @cart_item.save!
      flash[:success] = "カートに商品を追加しました"
      redirect_to customer_cart_items_path(current_customer)
    else
      @cart_item = current_customer.cart_items.find_by(product_id: params[:product_id])
      @cart_item.update(cart_params)
      flash[:success] = "カートに商品を追加しました"
      redirect_to customer_cart_items_path(current_customer)
    end
  end

  def search_results
    @q = Product.search(search_params)
    @products = @q.result(distinct: true).page(params[:page])
  end

  private

    def search_params
      params.require(:q).permit(:name_cont)
    end

    def cart_params
      params.require(:cart_item).permit(:product_id, :quantity)
    end
end
