class CustomersController < ApplicationController

  before_action :ensure_correct_customer, {only: [:show, :exit, :update, :destroy]}

  def show
    @customer = Customer.find(params[:id])
    @reviews = @customer.reviews.page(params[:page]).per(5)

  end

  def update
      @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        redirect_to customer_path(@current_customer.id)
      else
        @reviews = @customer.reviews.page(params[:page]).per(5)
        render :show
      end
    end

  def destroy
      @customer = Customer.find(params[:id])
      # 退会権限はユーザー本人のみに与えるよ！
      if @customer.id == current_customer.id
		    @customer.destroy
		    redirect_to root_path
      end
    end

   def exit
   	@customer = Customer.find(params[:id])
   end

  #ここでユーザーのみが編集できるようにチェックするよ！
    def ensure_correct_customer
      @customer = Customer.find(params[:id])
      #ユーザーIDのチェックするよ！
    unless @customer.id == current_customer.id
		  redirect_to customer_path(current_customer)
    end
  end

private
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code1, :postal_code2, :prefecture_code, :city, :building, :phone_number1, :phone_number2, :phone_number3)
  end
end
