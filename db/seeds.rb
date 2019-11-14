# 商品情報のサンプルデータ
20.times do |n|
  name  = "Product-#{n+1}"
  price = "#{n*100}"
  release_date = "2019/1/#{n+1}"
  Product.create!(name:  name,
                  price: price,
                  image_id: 1,
                  release_date: release_date,
                  status:     0,
                  description: "sample text sample text sample text sample text sample text",
                  artist_id: 1,
                  category_id: 1,
                  company_id: 1,
                  deleted_at: "")
end


# アーティスト情報 artists

# ジャンル情報
# レーベル情報
