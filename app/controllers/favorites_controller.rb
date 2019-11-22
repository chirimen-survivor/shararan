class FavoritesController < ApplicationController

	skip_before_action :authenticate_customer!

	def index
		@customer = Customer.find(params[:customer_id])
		@favorites = @customer.favorites.page(params[:page]).per(10)
		# @product = Product.find(params[:product_id])
	end

	def create
		@product = Product.find(params[:product_id])
		unless @product.good?(current_customer)
			@product.good(current_customer)
			@product.reload
			respond_to do |format|
				format.html {redirect_to request.referrer || root_url}
				format.js
			end
		end
	end

	def destroy
		@product = Product.find(params[:product_id])
		# @favorite = @favorites.find_by(customer_id: current_customer.id)
		if @product.good?(current_customer)
			@product.ungood(current_customer)
			@product.reload
			respond_to do |format|
				format.html {redirect_to request.referrer || root_url}
				format.js
			end
		end
	end
end
