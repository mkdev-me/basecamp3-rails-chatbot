require 'httparty'

class ChatbotService
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def post_message(options)
    message = "Subject: #{options[:subject]}<br/> #{options[:message]}"

    # send message to basecamp
    HTTParty.post(url, query: { content: message })
  end

  def confirm_subscribe!
    return nil unless url.present?
    HTTParty.get(subscribe_url)
  end
end
