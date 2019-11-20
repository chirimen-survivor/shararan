class Managers::OrdersController < ApplicationController

	# before_action :ensure_correct_customer, {only: [:new, :create, :select, :index, :show, :complete]}

	def index
		@orders = Order.all
	end

	def show
		@order = Order.find(params[:id])
		#@order_detail = OrderDetail.find(params[:order_id])
		@order_details = OrderDetail.where(order_id: @order.id)
	end

	private

	def order_params
		params.require(:order).permit(:postal_code1, :postal_code2, :prefecture_code, :city, :building, :total, :status, :tax_id, :product_id, :customer_id, :payment, :postage_id, :quantity,)
	end

	def order_detail_params
		params.require(:order_detail).permit(:order_id, :product_id, :subtotal, :quantity)
	end

end
