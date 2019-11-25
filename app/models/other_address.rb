class OtherAddress < ApplicationRecord
	belongs_to :customer


	has_many :orders


	include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  	# バリデーションチェック
	validates :last_name, presence: true, length: {minimum: 1}
	validates :first_name, presence: true, length: {minimum: 1}
	validates :last_name_kana, presence: true, length: {minimum: 1}
	validates :first_name_kana, presence: true, length: {minimum: 1}
	validates :postal_code1, presence: true, length: {minimum: 1, maximum: 3}
	validates :postal_code2, presence: true, length: {minimum: 1, maximum: 4}
	validates :prefecture_code, presence: true, numericality: {less_than_or_equal_to: 47}
	validates :city, presence: true, length: {minimum: 1, maximum: 200}
	validates :building, presence: true, length: {minimum: 1, maximum: 200}
	validates :phone_number1, presence: true, length: {minimum: 1, maximum: 4}, numericality: { only_integer: true }
	validates :phone_number2, presence: true, length: {minimum: 1, maximum: 4}, numericality: { only_integer: true }
	validates :phone_number3, presence: true, length: {minimum: 1, maximum: 4}, numericality: { only_integer: true }

end
