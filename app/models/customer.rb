class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :review

  # 都道府県コードを入れるために以下は必要
  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  acts_as_paranoid

  #バリデーションチェック
  validates :last_name, presence: true, length: {minimum: 1, maximum: 50}
  validates :first_name, presence: true, length: {minimum: 1, maximum: 50}
  validates :last_name_kana, presence: true, length: {minimum: 1, maximum: 50}
  validates :first_name_kana, presence: true, length: {minimum: 1, maximum: 50}
  validates :postal_code1, presence: true, length: {minimum: 1, maximum: 3}
  validates :postal_code2, presence: true, length: {minimum: 1, maximum: 4}
  validates :prefecture_code, presence: true, numericality: {less_than_or_equal_to: 47}
  validates :city, presence: true, length: {minimum: 1, maximum: 200}
  validates :building, presence: true, length: {minimum: 1, maximum: 200}
  validates :phone_number1, presence: true, length: {minimum: 1, maximum: 4}, numericality: { only_integer: true }
  validates :phone_number2, presence: true, length: {minimum: 1, maximum: 4}, numericality: { only_integer: true }
  validates :phone_number3, presence: true, length: {minimum: 1, maximum: 4}, numericality: { only_integer: true }
end
