class CartItemsController < ApplicationController
  before_action :correct_customer, only: [:index, :create, :destory]

  def index
    @customer = Customer.find(params[:customer_id]) # beforeアクションで定義しているのでなくても大丈夫だが、わかりやすくするため
    @cart_items = CartItem.where(customer_id: @customer.id)
  end

  private

    # 正しいユーザーかどうか確認
    def correct_customer
      @customer = Customer.find(params[:customer_id])
      if current_customer.id != @customer.id
        redirect_to root_path
      end
    end
end
