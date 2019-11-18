class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		blog = Contact.new(contact_params)
   		blog.save
    	redirect_to new_contact_path
	end
	def index
		@contacts = Contact.all
	end

	def show
		@contact = Contact.find(params[:id])
	end


	def update

	end

	private

	def contact_params
	      params.require(:contact).permit(:email,:title,:body)
	end
end
