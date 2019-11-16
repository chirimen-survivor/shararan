class Product < ApplicationRecord

  has_many :review

  attachment :image

end
