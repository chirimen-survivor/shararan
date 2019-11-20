class Managers::ContactsController < ApplicationController
	def index
		@contacts = Contact.all
		#binding.pry
	end

	def show
		@contact = Contact.find(params[:id])
		@customer = Customer.find(params[:id])
	end

	def update
		@contact = Contact.find(params[:id])
		if @contact.update(contact_params)
		   redirect_to managers_contact_path(@contact), notice: "メールを送信しました！"
		   InquiryMailer.send_mail(@contact).deliver
		else
			@constact = Contact.all
			render :index
		end
	end

	private

	def contact_params
	      params.require(:contact).permit(:email,:title,:body,:reply_message)
    end
end
