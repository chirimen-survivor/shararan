class Review < ApplicationRecord
	belongs_to :customer

	belongs_to :product

	validates :rating, presence: true
	validates :title, presence: true, length: {maximum: 50}
	validates :body, presence: true, length: {maximum: 200}
end
