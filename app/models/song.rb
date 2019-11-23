class Song < ApplicationRecord
  belongs_to :disc

  validates :name, presence: true, length: { maximum: 30 }
end
