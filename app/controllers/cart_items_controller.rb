class CartItemsController < ApplicationController
  before_action :correct_customer, only: [:index]
  before_action :confirm_cartitem, only: [:destroy]

  def index
    @customer = Customer.find(params[:customer_id]) # beforeアクションで定義しているのでなくても大丈夫だが、コードをわかりやすくするため
    @cart_item = CartItem.find_by(customer_id: @customer.id)
    @cart_items = CartItem.where(customer_id: @customer.id)
  end

  def destroy
    @cart_item = current_customer.cart_items.find_by(product_id: params[:product_id])
    @cart_item.destroy
    redirect_to customer_cart_items_path(current_customer)
  end

  def update
    @cart_item = current_customer.cart_items.find_by(product_id: params[:product_id])
    @cart_item.update(quantity: params[:cart_item][:quantity])
    redirect_to customer_cart_items_path(current_customer)
  end


  private

    # 正しいユーザーかどうか確認
    def correct_customer
      if current_customer.id != params[:customer_id].to_i
        redirect_to root_path
      end
    end

    #  カートの中身が空になったら、rootへ飛ばす
    def confirm_cartitem
      @cart_item = CartItem.where(customer_id: current_customer.id)
      if @cart_item.count == 1
        #  @cart_item.destroy
         redirect_to root_path
      end
    end

    def cart_params
      params.require(:cart_item).permit(:product_id, :quantity)
    end

end
