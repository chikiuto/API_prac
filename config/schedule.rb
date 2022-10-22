# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
# Learn more: http://github.com/javan/whenever

# 【参考】https://qiita.com/Esfahan/items/e7a924f7078faf3294f2
# Rails.root(Railsメソッド)を使用するために必要
require File.expand_path(File.dirname(__FILE__) + '/environment')
# cronを実行する環境変数(:development, :product, :test)を定義
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット(今回はdevelopment)
set :environment, rails_env
# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

# 毎日実行
# every 1.day, at: '2:52 pm' do
every 1.day, at: '3:15 pm' do
  rake 'bat:update_category_table'
end