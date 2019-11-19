class OrdersController < ApplicationController

	# before_action :ensure_correct_customer, {only: [:new, :create, :select, :index, :show, :complete]}

	def index
		# 購入履歴を表示する
		# 顧客情報
		@customer = Customer.find(params[:customer_id])
		# @ordersに個人の購入履歴
		@orders = @customer.orders
		# ページネーション
		@orders = Order.page(params[:page]).per(10)
	end

	def show
		# 購入履歴詳細画面を表示する
		@customer = Customer.find(params[:customer_id])
		@orders = @customer.orders
		@order = Order.find(params[:id])
		# @order1 = Order_detail.find(params[:id])
	end

	private

	def order_params
		params.require(:order).permit(:postal_code1, :postal_code2, :prefecture_code, :city, :building, :total, :status, :tax_id, :product_id, :customer_id, :payment, :postage_id, :quantity,)
	end

	def order_detail_params
		params.require(:order_detail).permit(:order_id, :product_id, :subtotal, :quantity)
	end

end
