class Arrival < ApplicationRecord
	belongs_to :product

	validates :quantity, presence: true, numericality: { only_integer: true }
end
