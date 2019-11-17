class Managers::CustomersController < ApplicationController
  skip_before_action :authenticate_customer!, only: [:index, :show, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @reviews = @customer.reviews.page(params[:page])
    @review = Review.find(params[:id])
  end

  def update
      @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        redirect_to managers_customer_path(@customer.id)
      else
        @Customers = Customers.all
        render action: :show
      end
    end

  def destroy
      @customer = Customer.find(params[:id])
      @customer.destroy
		  redirect_to root_path
    end

private
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code1, :postal_code2, :prefecture_code, :city, :building, :phone_number1, :phone_number2, :phone_number3)
  end
end
