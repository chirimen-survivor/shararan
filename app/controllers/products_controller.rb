class ProductsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show, :search_results]

  def index
    @products = @q.result(distinct: true).page(params[:page])
    @all_ranks = Product.find(Favorite.group(:product_id).order('count(product_id) desc').limit(3).pluck(:product_id))
  end

  def show
    @review = Review.new
    @product = Product.find(params[:id])
    @reviews = @product.reviews.page(params[:page])
    @cart_item = CartItem.new(product_id: @product.id)
    @discs = @product.discs.all.order(sequence: 'ASC')
    @details = OrderDetail.where(product_id: @product.id)
    # 在庫数管理
    @details = OrderDetail.where(product_id: @product.id)
    @stock = @product.arrivals.sum(:quantity) - @details.sum(:quantity)
    @current_stock_array = []
    # stock回数分だけ回す！
    @stock.times do |quantity|
      if quantity < 10
        @current_stock_array.push(quantity + 1)
      else
        break
      end
    end
  end

  # カートに入れる
  def create
    @product = Product.find(params[:product_id])
    @cart_item = CartItem.new(cart_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.product_id = @product.id
    unless same_cartitem(@product).exists?
      @cart_item.save!
      flash[:notice] = "カートに商品を追加しました"
      redirect_to customer_cart_items_path(current_customer)
    else
      @cart_item = current_customer.cart_items.find_by(product_id: params[:product_id])
      @cart_item.update(cart_params)
      flash[:notice] = "カートに商品を追加しました"
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

     # 現在のユーザーがカートに同じ商品を持っていないか確認
     def same_cartitem(product)
      CartItem.where(product_id: product.id).where(customer_id: current_customer.id)
     end
end
