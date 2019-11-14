class ProductsController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show]

  def index
  end

  def show
    @customer = Customer.find(params[:id])
  end
end
