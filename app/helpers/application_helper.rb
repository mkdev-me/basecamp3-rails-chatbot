module ApplicationHelper
  require 'json'
  require 'httparty'

  # Parse JSON request from remote calback server
  def parse_webhook
    # Handle exceptions in case of failed request
    JSON.parse request.body.read
  rescue JSON::ParserError => error
    return { error: error.to_s }
  end

  # Send message to Basecamp Campfire via ChatBot
  def send_message(message)
    basecampbot_url = Rails.configuration.service['basecampbot_url']
    HTTParty.post basecampbot_url, query: { content: message }
  end
end
