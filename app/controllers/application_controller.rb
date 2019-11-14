class ApplicationController < ActionController::Base

	 before_action :authenticate_customer!
	 before_action :configure_permitted_parameters, if: :devise_controller?




	protected
	  def configure_permitted_parameters
	  	devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,
	  		:last_name_kana, :first_name_kana, :postal_code1, :postal_code2, :prefecture_code,
	  		:city, :building, :phone_number1, :phone_number2, :phone_number3, :email])
	  end

end
