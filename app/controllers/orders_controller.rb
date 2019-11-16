class OrdersController < ApplicationController
	def new
	end


	def create
		@order = Order.new(order_params)
	end


	def select

	end


	def index
		# @customer = Customer.find(params[:id])
		# @orders = @customer.orders
	end


	def show

	end


	def complete

	end

	private

	def order_params
		params.require(:order).permit(:postal_code1, :postal_code2, :prefecture_code, :city, :building, :total, :status, :paymemnt, :quantity)
	end


end
