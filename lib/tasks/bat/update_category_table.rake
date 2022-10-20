require 'json'

namespace :bat do
  desc 'update category table'
  # config/environment.rbを読み込み、環境ごとの設定を反映してから update_category_table を実行
  task update_category_table: :environment do
    # 具体的な処理を実装

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
      
      # df_append = pd.DataFrame(data=list_medium, columns=category_columns)
      # category_df = pd.concat([category_df, df_append], ignore_index=True, axis=0)
      parent_dict[category['categoryId'].to_s] = category['parentCategoryId']
    end

    # print(parent_dict)
    
    # 小カテゴリ
    hash_data['result']['small'].each do |category|
      list_small = [ parent_dict[category['parentCategoryId']],
                     category['parentCategoryId'],
                     category['categoryId'],
                     parent_dict[category['parentCategoryId']].to_s + "-" + category['parentCategoryId'].to_s + "-" + category['categoryId'].to_s,
                     category['categoryName']
                    ]
      $category_ary.push(list_small)
      
      # df_append = pd.DataFrame(data=list_small, columns=category_columns)
      # category_df = pd.concat([category_df, df_append], ignore_index=True, axis=0)
    end

  end
end