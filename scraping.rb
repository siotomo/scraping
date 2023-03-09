# frozen_string_literal: true

# selenium-webdriverを取り込む
require 'selenium-webdriver'
require 'pry-byebug'

# ブラウザの指定(Chrome)
driver = Selenium::WebDriver.for :chrome
# 10秒待っても読み込まれない場合は、エラーが発生する
driver.manage.timeouts.implicit_wait = 10
# ページ遷移する
driver.navigate.to 'https://www.cityheaven.net/tokyo/A1316/A131603/ultra-galaxy/girlid-38567541'
# 予約ページへの遷移
driver.find_element(:id, 'reserve_btn').click
sleep(3)
driver.navigate.to(driver.find_element(:id, 'pcreserveiframe').attribute('src'))

trs = driver.find_elements(:tag_name, 'tr')
tr = trs.find { |tr| tr.find_elements(:tag_name, 'th')[0]&.text == '20:00-'}
tr.find_elements(:tag_name, 'td')[1].click

binding.pry
# "zenn"を自動入力する
query.send_keys('zenn')

# 送信(検索)
query.submit

# 5秒遅延(処理が早すぎてページ遷移前にスクリーンショットされてしまうため)
sleep(5)

# スクリーンショットをして"zenn.png"で保存する(保存される場所は、コード実行箇所)
if driver.save_screenshot('zenn.png')
  # スクリーンショットができたら出力する
  puts 'スクリーンショットされました！'
end
