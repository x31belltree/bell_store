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
{ name: '鈴木', email: 'bell@test.com', password: '123456',address: '東京都品川区x-x-x' },
{ name: '佐藤', email: 'sugar@test.com', password: '123456',address: '東京都目黒区区x-x-x'}
]

users.each do |record|
 User.create!(record) unless User.find_by(email: record[:email])
end

lady = Category.create(name: "レディース")
lady.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"},{name: "Tシャツ/カットソー(七分/長袖)"},{name: "シャツ/ブラウス(半袖/袖なし)"},{name: "シャツ/ブラウス(七分/長袖)"},{name: "ポロシャツ"},{name: "キャミソール"},{name: "タンクトップ"},{name: "ホルターネック"},{name: "ニット/セーター"},{name: "チュニック"},{name: "カーディガン/ボレロ"},{name: "アンサンブル"},{name: "ベスト/ジレ"},{name: "パーカー"},{name: "トレーナー/スウェット"},{name: "ベアトップ/チューブトップ"},{name: "ジャージ"},{name: "その他"}])

men = Category.create(name: "メンズ")
men.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"},{name: "Tシャツ/カットソー(七分/長袖)"},{name: "シャツ"},{name: "ポロシャツ"},{name: "タンクトップ"},{name: "ニット/セーター"},{name: "パーカー"},{name: "カーディガン"},{name: "スウェット"},{name: "ジャージ"},{name: "ベスト"},{name: "その他"}])

# ベビー・キッズ
baby_kids = Category.create(name: "ベビー・キッズ")
baby_kids.children.create([{name: "トップス"},{name: "アウター"},{name: "パンツ"},{name: "スカート"},{name: "ワンピース"},{name: "ベビードレス"},{name: "おくるみ"},{name: "下着/肌着"},{name: "パジャマ"},{name: "ロンパース"},{name: "その他"}])

15.times do |i|
 Product.create!(name: "商品サンプル#{format("%02d",1+i)}",detail: "商品サンプル#{format("%02d",1+i)}の説明です" ,price: "#{i*100}" ,stock: "#{i+1}" )
end