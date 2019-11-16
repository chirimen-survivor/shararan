class Managers::ProductsController < Managers::ApplicationController
skip_before_action :authenticate_customer!, only: [:index, :show, :new]


  def new
    @product = Product.new
  end

  def index
  end

  def show
  end
end
