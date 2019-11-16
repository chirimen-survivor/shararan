class OtherAddressesController < ApplicationController
 def index
 	other_address = OtherAddress.new
    @other_address = OtherAddress.all
 end
end
