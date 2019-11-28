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

 def update
 	@review = Review.find(params[:id])
 	if @review.update(
 		title: params[:review][:title],
 		body: params[:review][:body],
 		rating: params[:review][:rating][params[:id]],
 		created_at: params[:review][:created_at],
 		)
 		redirect_to managers_product_path(@review.product_id)
 	else
 		render "products/show"
 	end
 end


 def destroy
 	@review = Review.find(params[:id])
 	@review.destroy
 	redirect_to managers_product_path(@review.product_id)
 end

private
	def review_params
		params.require(:review).permit(:rating, :title, :body, :customer_id, :product_id)
	end

	def exit_review_params
		params.require(:review).permit(:title, :body, :created_at, rating:[])
	end
end
