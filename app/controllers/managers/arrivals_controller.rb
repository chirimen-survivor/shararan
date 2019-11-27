class Managers::ArrivalsController < ApplicationController

	def index
		@arrivals = Arrival.includes(:product).all.order(id: "DESC").page(params[:page]).per(20)
	end

	private
	def arrival_params
		params.require(:arrival).permit(:quantity, :product_id)
	end
end
