class Review < ApplicationRecord
	belongs_to :customers
	belongs_to :products
end
