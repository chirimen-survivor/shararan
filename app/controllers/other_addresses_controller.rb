class OtherAddressesController < ApplicationController
  def index
  	@other_address = Other_address.all

  end
  def create
  	@other_address = Other_address.new(other_address_params)
  	other_address.save
  	redirect_to other_addresses_path
  end

  def edit
  end

  def update
  	
  end

  private

  def other_address_params
  	params.require(:Other_address).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_cadde1,:postal_cadde2,:prefecture_code,:city,:building,:building,:phone_number1,:phone_number2,:phone_number3)
  end
end
