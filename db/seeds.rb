# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  id: 1,
  email: 'admin@user',
  password: 'adminuser',
  password_confirmation: 'adminuser'
  )

users = [
{ name: '鈴木テス男', email: 'bell@test.com', password: '123456',address: '東京都品川区x-x-x' },
{ name: '佐藤テス子', email: 'sugar@test.com', password: '123456',address: '東京都目黒区x-x-x'}
]

users.each do |record|
 User.create!(record) unless User.find_by(email: record[:email])
end

Category.create([{name: "レディース/Tシャツ"},{name: "レディース/ブラウス"},{name: "レディース/ポロシャツ"},{name: "メンズ/Tシャツ"},{name: "メンズ/シャツ"},{name: "メンズ/ポロシャツ"},{name: "メンズ/タンクトップ"},{name: "ニット/セーター"},{name: "その他"}])

15.times do |i|
 Product.create!(name: "商品サンプル#{format("%02d",i+1)}",detail: "商品サンプル#{format("%02d",i+1)}の説明です" ,price: "#{i+1*100}" ,stock: "#{i+1}" )
end