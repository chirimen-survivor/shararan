class Product < ApplicationRecord

  has_many :reviews
  has_many :review
  
  attachment :image

end
