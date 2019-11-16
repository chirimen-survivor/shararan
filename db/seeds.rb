# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#マスターデータ（カスタマー）のデータ
Customer.create!(
	last_name:  "test",
	first_name: "test",
	last_name_kana: "test",
	first_name_kana: "test",
	postal_code1: '123',
	postal_code2: '1234',
	prefecture_code: 1,
	city: 'test',
	building: 'test',
	phone_number1: '123',
	phone_number2: '123',
	phone_number3: '123',
	email: 'test@test',
	password: '123456',
	deleted_at: "",
	)


# カスタマーのサンプルデータ
50.times do |n|
	last_name = Faker::Name.name,
	first_name = Faker::Name.name,
	last_name_kana = Faker::Name.name,
	first_name_kana = Faker::Name.name,
	postal_code1 = Faker::Number.between(from: 100, to: 999),
	postal_code2 = Faker::Number.between(from: 1000, to: 9999),
	prefecture_code = Faker::Number.between(from: 1, to: 47),
	city = Faker::Address.city,
	building = Faker::Address.street_address,
	phone_number1 = Faker::Number.between(from: 1, to: 9999),
	phone_number2 = Faker::Number.between(from: 1, to: 9999),
	phone_number3 = Faker::Number.between(from: 1, to: 9999),
	email = Faker::Internet.free_email,
	password = Faker::Number.between(from: 100000, to: 999999),
	deleted_at = ""
	Customer.create!(
	last_name: last_name,
	first_name: first_name,
	 last_name_kana: last_name_kana,
	first_name_kana: first_name_kana,
	postal_code1: postal_code1,
	postal_code2: postal_code2,
	prefecture_code: prefecture_code,
	city: city,
	building: building,
	phone_number1: phone_number1,
	phone_number2: phone_number2,
	phone_number3: phone_number3,
	email: email,
	password: password,
	deleted_at: ""
	)
end

# 商品情報のサンプルデータ
20.times do |n|
  name  = "Product-#{n+1}"
  price = "#{100+n*100}"
  release_date = "2019/1/#{n+1}"
  description = "sample text sample text sample text sample text sample text" * 2
  Product.create!(name:  name,
                  price: price,
                  image_id: 1,
                  release_date: release_date,
                  status:     0,
                  description: description,
                  artist_id: 1,
                  category_id: 1,
                  company_id: 1,
                  deleted_at: "")
end

20.times do |n|
	Review.create!(
			rating: 3.5,
			title: "いいね",
			customer_id: n,
			product_id: n,
			body: "いいね")
end

# アーティスト情報 artists
10.times do |n|
	Artist.create!(
		name: Faker::Music.band
	)
end
# ジャンル情報 categories
10.times do |n|
	Categorie.create!(
		name: Faker::Music.genre
	)
end
# レーベル情報 companies
10.times do |n|
	Company.create!(
		name: "Record Label#{n+1}"
	)
end
