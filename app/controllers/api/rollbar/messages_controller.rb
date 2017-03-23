class Api::Rollbar::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_request_format, only: [:create]

  def create
   # Get the parsed JSON string
    payload = helpers.parse_webhook

    event = payload['event_name']
    data = payload['data']

    # Prepare message for the campfire
    message = "Subject: #{event}<br/>  Body: #{data}"

    # send message to basecamp
    helpers.send_message(message)

    
  end

  private

  def check_request_format
    return head :bad_request unless request.format.json?
  end

end