class Product < ApplicationRecord
    # テーブルのリレーション
    has_many :artists
    has_many :categories
    has_many :company

    # gemの設定関連
    attachment :image
    acts_as_paranoid

    #バリデーションチェック
    validates :name, presence: true, length: {minimum: 1, maximum: 20}
    validates :price, presence: true, numericality: { only_integer: true }, length: {minimum: 1, maximum: 8}
    validates :release_date, presence: true
    validates :description, presence: true, length: {minimum: 1}
    validates :artist_id, presence: true
    validates :category_id, presence: true
    validates :company_id, presence: true

    enum status: { 販売停止: 0, 販売中: 1 }
end
