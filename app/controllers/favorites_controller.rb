class FavoritesController < ApplicationController

	def create
		@product = Product.find(params[:product_id])
		unless @product.good?(current_customer)
			@product.good(current_customer)
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
			respond_to do |format|
				format.html {redirect_to request.referrer || root_url}
				format.js
			end
		end
	end
end
