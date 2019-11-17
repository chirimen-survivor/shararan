class OrdersController < ApplicationController

	# before_action :ensure_correct_customer, {only: [:new, :create, :select, :index, :show, :complete]}

	def new
		# 購入確認画面を表示する
		@order = Order.find(params[:id])
	end


	def create
		# 購入情報を確定する
		@order = Order.new(order_params)
		if @order.save
			redirect_to order_path(@order.id)

		else
			render :select
		end
	end


	def select
		# 顧客情報
		@customer = Customer.find(params[:id])
		# 配送先、支払い方法を選択するために空
		@order = Order.find(order_params)


		# @ordersに個人の購入履歴
		# @addresses = @customer.other_addresses

	end


	def index
		# 購入履歴を表示する
		# 顧客情報
		@customer = Customer.find(params[:id])
		# @ordersに個人の購入履歴
		@orders = @customer.orders
	end

	def show
		# 購入履歴詳細画面を表示する

	end


	def complete
		# 購入完了画面を表示する

	end

	private

	def order_params
		params.require(:order).permit(:postal_code1, :postal_code2, :prefecture_code, :city, :building, :total, :status, :paymemnt, :quantity)
	end


end
