class Favorite < ApplicationRecord
	belongs_to :customer
	belongs_to :product
	counter_culture :product
end
