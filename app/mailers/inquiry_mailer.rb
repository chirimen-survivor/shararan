class InquiryMailer < ApplicationMailer
	def send_mail(contact)
		@contact = contact
		mail(
			from: 'manager@example.com',
			top: 'system@example.com',
			subject: 'しゃららんへのお問い合わせについて'
			)
	end
end
