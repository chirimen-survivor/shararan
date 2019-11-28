class OtherAddressesController < ApplicationController
 def index
    @other_address = OtherAddress.new
    @other_addresses = OtherAddress.all
 end

 def create
    @other_address = OtherAddress.new(other_addresses_params)
    @other_address.customer_id = current_customer.id
    if @other_address.save
       flash[:notice] = "登録されました"
       redirect_to other_addresses_path
    else
        @other_addresses = OtherAddress.all
        flash[:alert] = "入力項目が足りません"
        render :index
      end
  end

  def edit
    @other_address = OtherAddress.find(params[:id])
  end

  def update
    other_address = OtherAddress.find(params[:id])
    other_address.update(other_addresses_params)
    redirect_to other_addresses_path(other_address)

  end

  def destroy
    other_address = OtherAddress.find(params[:id])
    other_address.destroy
    redirect_to other_addresses_path
  end

  private

  def other_addresses_params
      params.require(:other_address).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code1,:postal_code2,:prefecture_code,:city,:building,:building,:phone_number1,:phone_number2,:phone_number3)
  end
end

