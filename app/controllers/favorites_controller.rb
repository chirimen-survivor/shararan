class FavoritesController < ApplicationController

	skip_before_action :authenticate_customer!

	def index
		@customer = Customer.find(params[:customer_id])
		@favorites = @customer.favorites.page(params[:page]).per(10)
	end

	def create
		@product = Product.find(params[:product_id])
		unless @product.good?(current_customer)
			# いいねを追加
			@product.good(current_customer)
			#アイコンの切り替え時に必要
			@product.reload
			# 以下は非同期通信
			respond_to do |format|
				format.html {redirect_to request.referrer || root_url}
				format.js
			end
		end
	end

	def destroy
		@product = Product.find(params[:product_id])
		if @product.good?(current_customer)
			#いいねを削除
			@product.ungood(current_customer)
			#アイコンの切り替え時に必要
			@product.reload
			# 以下は非同期通信
			respond_to do |format|
				format.html {redirect_to request.referrer || root_url}
				format.js
			end
		end
	end
end
