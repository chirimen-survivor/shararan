class InquiryMailer < ApplicationMailer
	def send_mail
		@contact = params[:Inquiry]
		mail(
			from: 'manager@example.com',
			to: @contact.email,
			subject: 'しゃららんへのお問い合わせについて'
			)
	end


	def send_when_create(order, customer)
		@order =  order
		@customer = customer
		mail(
			from: 'manager@example.com',
			to: @customer.email,
			subject: 'このたびは、「しゃららん」をご利用いただきありがとうございます。'
			)
	end


end
