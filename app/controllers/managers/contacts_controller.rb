class Managers::ContactsController < Managers::ApplicationController
	def index
		@contacts = Contact.includes(:customer).all
		#binding.pry
	end

	def show
		@contact = Contact.find(params[:id])
		@customer = Customer.find_by(id: @contact.customer_id)
	end

	def update
		@contact = Contact.find(params[:id])
		if @contact.update(contact_params)
		   redirect_to managers_contact_path(@contact), notice: "メールを送信しました！"
		   InquiryMailer.with(Inquiry: @contact).send_mail.deliver_later
		else
			@contact = Contact.find(params[:id])
			@customer = Customer.find_by(id: @contact.customer_id)
			flash.now[:alert] = "返信内容を入力してください"
			render :show

		end
	end

	private

	def contact_params
	      params.require(:contact).permit(:email,:title,:body,:reply_message)
    end


end
