class InquiryMailer < ApplicationMailer
	def send_mail
		@inquiry = inquiry
		mail(
			from: 'manager@example.com',
			top: 'system@example.com',
			subject: 'しゃららんへのお問い合わせについて'
			)
	end
end
