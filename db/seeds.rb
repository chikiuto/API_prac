# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

uri = URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=1038863537950891238')
API_json_data = Net::HTTP.get(uri)
# rubyではjsonをhashにして扱わなければならない
hash_data = JSON.parse(API_json_data) 
# result = hash['result']['large']

$category_ary = [] # jsonを入れる配列
parent_dict = {} # mediumカテゴリの親カテゴリの辞書

# 大カテゴリ
hash_data['result']['large'].each do |category|
  list_large = [category['categoryId'],
                "",
                "",
                category['categoryId'],
                category['categoryName']
               ]
  $category_ary.push(list_large)
end

# 中カテゴリ
hash_data['result']['medium'].each do |category|
  list_medium = [category['parentCategoryId'],
                 category['categoryId'],
                 "",
                 category['parentCategoryId'].to_s + "-" + category['categoryId'].to_s,
                 category['categoryName']
                ]
  $category_ary.push(list_medium)
  

  parent_dict[category['categoryId'].to_s] = category['parentCategoryId']
end

# 小カテゴリ
hash_data['result']['small'].each do |category|
  list_small = [ parent_dict[category['parentCategoryId']],
                 category['parentCategoryId'],
                 category['categoryId'],
                 parent_dict[category['parentCategoryId']].to_s + "-" + category['parentCategoryId'].to_s + "-" + category['categoryId'].to_s,
                 category['categoryName']
                ]
  $category_ary.push(list_small)
end

$category_ary.each do |cate|
  category = Category.create( category1: cate[0],                                                    
                              category2: cate[1],                                                    
                              category3: cate[2],                                                    
                              categoryId: cate[3],                                                   
                              categoryName: cate[4]
                            )

# postgreSQL起動
# $ rails dbconsole
# 中身確認
# API_prac_development=# select * from categories;

end

