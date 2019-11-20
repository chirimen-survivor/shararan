class InquiryMailer < ApplicationMailer
	def send_mail
		@contact = params[:Inquiry]
		mail(
			from: 'manager@example.com',
			to: @contact.email,
			subject: 'しゃららんへのお問い合わせについて'
			)
	end
end
