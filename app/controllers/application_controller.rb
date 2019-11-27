class ApplicationController < ActionController::Base

	 before_action :authenticate_customer!
	 before_action :configure_permitted_parameters, if: :devise_controller?
	 before_action :set_search

	 def set_search
		@q = Product.includes(:categorie, :artist, :songs, :discs).ransack(params[:q])
  end

	 def after_sign_in_path_for(resource)
	 	if resource.class == Manager
			managers_products_path
		elsif resource.class == Customer
			root_path
		end
	 end

	protected
	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,
	  	:last_name_kana, :first_name_kana, :postal_code1, :postal_code2, :prefecture_code,
	  	:city, :building, :phone_number1, :phone_number2, :phone_number3, :email])
	end

end
