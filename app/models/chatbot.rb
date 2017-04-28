class Chatbot
  def self.parse_webhook(resp)
    JSON.parse resp
  # Handle exceptions in case of failed request
  rescue JSON::ParserError => error
    return { error: error.to_s }
  end

  def self.send_message(basecampbot_url, message)
    basecampbot_url ||= Rails.configuration.service['basecampbot_url']
    HTTParty.post basecampbot_url, query: { content: message }
  end
end
