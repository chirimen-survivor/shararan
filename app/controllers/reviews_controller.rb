class ReviewsController < ApplicationController
  def create
  	@product = Product.find(params[:product_id])
  	@review = Review.new(review_params)
	@review.customer_id = current_customer.id
	if @review.save
		redirect_to product_path(@product.id)
	else
		render template: "products/show"
	end
 end

private
	def review_params
		params.require(:review).permit(:rating, :title, :body, :customer_id, :product_id)
	end
end
