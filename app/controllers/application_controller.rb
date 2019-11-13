class ApplicationController < ActionController::Base

	protected
	  def configure_permitted_parameters
	  	devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, 
	  		:last_name_kana, :first_name_kana, :postal_code1, :postal_code2, :prefecture_code, 
	  		:city, :building, :phone_number1, :phone_number2, :phone_number3, :email])
	  end

end