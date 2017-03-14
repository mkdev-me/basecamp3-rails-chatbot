module Chatbot
  def self.post_message(url, options)
    message = MessageTempate.show(options)

    # send message to basecamp
    HTTParty.post(url, query: { content: message })
  end
end
