class Product < ApplicationRecord

    # テーブルのリレーション
    belongs_to :artist
    belongs_to :categorie
    belongs_to :company
    has_many :discs, dependent: :destroy

    accepts_nested_attributes_for :discs, allow_destroy: true

    # gemの設定関連

  has_many :reviews
  has_many :review

    attachment :image
    acts_as_paranoid

    #バリデーションチェック
    validates :name, presence: true, length: {minimum: 1, maximum: 20}
    validates :price, presence: true, numericality: { only_integer: true }, length: {minimum: 1, maximum: 8}
    validates :release_date, presence: true
    validates :description, presence: true, length: {minimum: 1}
    validates :artist_id, presence: true
    validates :categorie_id, presence: true
    validates :company_id, presence: true

    enum status: { 販売停止: 0, 販売中: 1 }

end
