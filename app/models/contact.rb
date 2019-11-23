class Contact < ApplicationRecord
	belongs_to :customer

	# バリデーションチェック
	validates :email, presence: true
	validates :title, presence: true
	validates :body, presence: true
	validates :reply_message, presence: true, on: :update 
end
