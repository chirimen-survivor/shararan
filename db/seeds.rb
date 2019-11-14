# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


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
