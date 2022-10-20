# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# ActiveSupport::JSONを使ってhoge.jsonをデコードしてrubyオブジェクトに変換。変数jsonに展開
json = ActiveSupport::JSON.decode(File.read('db/category.json'))

# 変数jsonに入った配列状態のjsonデータを一つ一つ取り出して、モデル.createを使ってdbに投入
json.each do |data|
  Category.create(column1:data['categoryId'], column2:data['categoryName'])
end