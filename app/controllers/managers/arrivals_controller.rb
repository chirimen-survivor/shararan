class Managers::ArrivalsController < ApplicationController

	def index
		@arrivals = Arrival.all.page(params[:page]).per(20)
	end
end
