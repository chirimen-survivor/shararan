class Managers::ReviewsController < ApplicationController
  def create
  	@product = Product.find(params[:product_id])
  	@review = Review.new(review_params)
	@review.customer_id = current_customer.id
	@review.product_id = @product.id
	if @review.save
		@reviews = @product.reviews.page(params[:page])
		redirect_to product_path(@product.id)
	else
		@reviews = @product.reviews.page(params[:page])
		render "products/show"
	end
 end

private
	def review_params
		params.require(:review).permit(:rating, :title, :body, :customer_id, :product_id)
	end
end
