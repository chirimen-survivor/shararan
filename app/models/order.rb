class Order < ApplicationRecord
	belongs_to :customer

	belongs_to :other_address
	has_many :order_details

	attachment :image


	include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end



	enum status: { 出荷準備中: 0, 発送済み: 1 }


	enum payment: { 現金振込: 0, クレジットカード: 1, 代引: 0 }


end
