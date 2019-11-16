class Product < ApplicationRecord
    attachment :image
    acts_as_paranoid

    #バリデーションチェック
    validates :name, presence: true, length: {minimum: 1, maximum: 20}
    validates :price, presence: true, numericality: { only_integer: true }, length: {minimum: 1, maximum: 8}
    validate  :image_size
    validates :release_date, presence: true
    validates :description, presence: true, length: {minimum: 1, maximum: 30}
    validates :artist_id, presence: true
    validates :category_id, presence: true
    validates :company_id, presence: true

    enum status: { 販売停止: 0, 販売中: 1 }

    private

    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "5MB以下のファイルを指定してください")
      end
    end
end
