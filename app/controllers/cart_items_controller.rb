class CartItemsController < ApplicationController
  before_action :correct_customer, only: [:index, :destory]

  def index
    @customer = Customer.find(params[:customer_id]) # beforeアクションで定義しているのでなくても大丈夫だが、コードをわかりやすくするため
    @cart_items = CartItem.where(customer_id: @customer.id)
  end

  # def create
  #   @product = Product.find(params[:product_id])
  #   @cart_item = CartItem.new(cart_params)
  #   @cart_item.customer_id = current_customer.id
  #   @cart_item.product_id = @product.id
  #   @cart_item.save!
  #   redirect_to customer_cart_items_path(@customer.id)
  # end

  private

    # 正しいユーザーかどうか確認
    def correct_customer
      @customer = Customer.find(params[:customer_id])
      if current_customer.id != @customer.id
        redirect_to root_path
      end
    end

    # def cart_params
    #   params.require(:cart_item).permit(:product_id, :quantity)
    # end
end
