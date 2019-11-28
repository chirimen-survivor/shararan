class ContactsController < ApplicationController
	def show
		@customer = Customer.find(params[:customer_id])
		@contact = Contact.new
	end

	def create
		@customer = Customer.find(params[:customer_id])
		@contact = Contact.new(contact_params)
		@contact.customer_id = current_customer.id
   		if @contact.save
   			flash[:notice] = 'Tanakaへ送りました'
    		redirect_to customer_contact_path(@customer.id, @contact)
    	else
    		flash[:notice] = 'Tanakaへ送信できませんでした'
    		render :show
    	end
	end

	private

	def contact_params
	      params.require(:contact).permit(:email,:title,:body,:reply_message)
    end
end