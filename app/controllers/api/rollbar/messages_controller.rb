class Api::Rollbar::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Get the parsed JSON string
    payload = helpers.parse_webhook

    # error: JSON:ParserError
    # Get the failed JSON request message
    request_error = payload[:error]

    # Store parsed dada from Rollerbar
    event = payload['event_name']
    data = payload['data']

    # Prepare message for the campfire
    if request_error
      message = "Failed request: #{request_error}"
    else
      message = "Subject: #{event}<br/>  Body: #{data}"
    end
    
    # send message to basecamp
    helpers.send_message(message)
  end
end
