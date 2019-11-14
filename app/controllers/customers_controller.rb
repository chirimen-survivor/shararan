class CustomersController < ApplicationController

  before_action :ensure_correct_customer, {only: [:show, :update, :destroy]}

  def show
    @customer = Customer.find(params[:id])
    @review = @customer.review
  end

  def update
      @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
         redirect_to customer_path(@customer.id)
      else
        @review = review.new
        @Customers = Customers.all
        render action: :show
      end
    end

  def destroy
      @customer = Customer.find(params[:id])
      # 退会権限はユーザー本人のみに与えるよ！
      if @customer.id == current_customer.id
          @customer.destroy
        redirect_to products_path
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
    # 都道府県コードも入れるの忘れるなよ！
    params.customer(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code1, :postal_code2, :prefecture_name, :city, :building, :phone_number1, :phone_number2, :phone_number3)
  end
end
