class Order < ApplicationRecord
	belongs_to :customer


	enum status: { 出荷準備中: 0, 発送済み: 1 }


	enum payment: { 現金振込: 0, クレジットカード: 1, 代引: 0 }


end
