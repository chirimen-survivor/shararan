class FavoritesController < ApplicationController
	def create
		@product = Product.find(params[:product_id])
		@favorite = current_customer.favorite.new(product_id: product.id)
		@favorite.save
		redirect_to product_path(@product.id)
	end
	def destroy
		@product = Product.find(params[:produxt_id])
		@favorite = current_customer.favorite.new(product_id: product.id)
		@favorite.destroy
		 redirect_to product_path(@product.id)
	end
end
