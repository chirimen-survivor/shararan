class ApplicationController < ActionController::Base
	 before_action :authenticate_customer!
end

# protected
#   # def configure_permitted_parameters
#   # 	devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
#   # end
# end