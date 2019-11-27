class Managers::OrdersController < ApplicationController

	# before_action :ensure_correct_customer, {only: [:new, :create, :select, :index, :show, :complete]}

	def index
		@orders = Order.all
	end

	def show
		@order = Order.find(params[:id])
		@details = OrderDetail.includes(:product).where(order_id: @order.id)
	end

	def update
		@order = Order.find(params[:id])
		if @order.update(order_status_params)
			@order = Order.find(params[:id])
			redirect_to managers_order_path(@order.id)
		else
			@details = OrderDetail.where(order_id: @order.id)
			render :show
		end
	end

	private

	def order_status_params
		params.require(:order).permit(:status)
	end

end
