# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

15.times do |i|
 Product.create!(name: "商品サンプル#{format("%02d",1+i)}",detail: "商品サンプル#{format("%02d",1+i)}の説明です" ,price: "#{i*100}" ,category: "カテゴリ1",image: "#{i+1}.jpg" ,stock: "#{i+1}" )
end

users= [
{ name: '管理者', email: 'admin@test.com', password: '123456',address: '東京都品川区x-x-x',admin: 'true' },
{ name: 'テストユーザ1', email: 'tanaka@test.com', password: '123456',address: '東京都品川区x-x-x',admin: 'false'  },
]
users.each do |record|
 User.create!(record) unless User.find_by(email: record[:email])
end