namespace :bat do
  desc 'update category table'
  # config/environment.rbを読み込み、環境ごとの設定を反映してからsample1を実行
  task update_category_table: :environment do
    # 具体的な処理を実装
    uri = URI.parse('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=1038863537950891238')
    json = Net::HTTP.get(uri)

    hash = JSON.parse(json)
    @result = hash["result"]
    print(@result)
  end
end