class OrdersController < ApplicationController

	# before_action :ensure_correct_customer, {only: [:new, :create, :select, :index, :show, :complete]}

	def new
		# 購入確認画面を表示する
		@customer = Customer.find(params[:customer_id])
		@order = Order.new(payment: params[:payment], customer_id: current_customer.id,postage_id: 1)
		@carts = CartItem.where(customer_id: @customer.id)
		@postage = Postage.find_by(id: @order.postage_id)
		# 住所が登録住所の場合
		if params[:address].to_i == 0
			@order.postal_code1 = @cusromer.postal_code1
			@order.postal_code2 = @cusromer.postal_code2
			@order.prefecture_name = @customer.prefecture_name
			@order.city = @customer.city
			@order.building = @customer.building
			@name = @customer.last_name + @customer.first_name
		else
			@address = OtherAddress.find(params[:address].to_i)
			@order.postal_code1 = @address.postal_code1
			@order.postal_code2 = @address.postal_code2
			@order.prefecture_name = @address.prefecture_name
			@order.city = @address.city
			@order.building = @address.building
			@name = @address.last_name + @address.first_name
		end
	end


	def create
		# 購入情報を確定する
		@order = Order.new
		@customer = Customer.find(params[:customer_id])
		@order.customer_id = current_customer.id
		# @order = Order.new(payment: params[:payment], customer_id: current_customer.id,postage_id: 1)
		# @order.customer_id = @customer.id
		@carts = CartItem.where(customer_id: current_customer.id)
		@postage = Postage.find_by(id: 1)
		@order.postage_id = @postage.id

		total_price = 0
		@carts.each do |cart|
			total_price += cart.product.price * cart.quantity
		end
		@order.status = 0
		@order.tax_id = 1
		@order.payment = params[:payment]
		@order.total = total_price + @postage.ship
		 if params[:address].to_i == 0
			@order.postal_code1 = @customer.postal_code1
			@order.postal_code2 = @customer.postal_code2
			@order.prefecture_name = @customer.prefecture_name
			@order.city = @customer.city
			@order.building = @customer.building
			@name = @customer.last_name + @customer.first_name
		else
			@address = OtherAddress.find(params[:address].to_i)
			@order.postal_code1 = @address.postal_code1
			@order.postal_code2 = @address.postal_code2
			@order.prefecture_name = @address.prefecture_name
			@order.city = @address.city
			@order.building = @address.building
			@name = @address.last_name + @address.first_name
		end

		@carts.each do |cart|
			@order_detail = @order.order_details.build
			@order_detail.product_id = cart.product_id
			@order_detail.subtotal = cart.product.price * cart.quantity
			@order_detail.quantity = cart.quantity
		end

		if @order.save
			redirect_to complete_customer_order_path(@order.id, @customer.id)
		else
			render :new
		end
	end


	def select
		# 顧客情報
		@customer = Customer.find(params[:customer_id])
		# 顧客のメイン以外の住所
		@addresses = @customer.other_addresses

		@carts = CartItem.where(customer_id: current_customer.id)
		@postage = Postage.find_by(id: 1)

	end


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
		# 顧客情報
		@customer = Customer.find(params[:customer_id])
		# 顧客の購入一覧
		@orders = @customer.orders
		# 一覧の中の一軒の購入情報
		@order = Order.find(params[:id])
		# その中の詳細
		@details = @order.order_details
		# 商品レビューや再度購入をするため
		@product = Product.find(params[:id])

	end


	def complete
		# 購入完了画面を表示する
	end

	private

	def order_params
		params.require(:order).permit(:postal_code1, :postal_code2, :prefecture_code, :city, :building, :total, :status, :tax_id, :product_id, :customer_id, :payment, :postage_id, :quantity,)
	end

	def order_detail_params
		params.require(:order_detail).permit(:order_id, :product_id, :subtotal, :quantity)
	end

end
