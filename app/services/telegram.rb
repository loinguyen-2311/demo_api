class Telegram
  def self.send
    group_id = ENV['CHAT_ID']
    url = "https://api.telegram.org/bot#{ENV['TELEGRAM_URL']}/sendMessage"
    HTTParty.post(url, body: { chat_id: group_id, text: "message" }.to_json, headers: { 'content-type' => 'application/json' }).parsed_response
  rescue StandardError => e
    debugger
    Sentry.capture_exception(e)
  end

  # 1000.times do |item|
  #   sleep 0.1
  #   group_id = ENV['CHAT_ID']
  #   url = "https://api.telegram.org/bot#{ENV['TELEGRAM_URL']}/sendMessage"
  #   HTTParty.post(url, body: { chat_id: group_id, text: "testing_#{item}" }.to_json, headers: { 'content-type' => 'application/json' }).parsed_response
  # end

end

# note
#
# add gem 'httparty'
#
# Chat with @BotFather
# /newbot and do follow instruction
#
# group_id ===> add bot vào group , gọi api https://api.telegram.org/bot{code_link}/getUpdates ==> chat_id

