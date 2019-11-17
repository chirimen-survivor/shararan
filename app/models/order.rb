class Order < ApplicationRecord
	belongs_to :customer


	enum status: { 出荷準備中: 0, 発送済み: 1 }


end
