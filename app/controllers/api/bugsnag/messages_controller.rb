class Api::Bugsnag::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Get the parsed JSON string
    @payload = helpers.parse_webhook

    # error: JSON:ParserError
    # Get the failed JSON request message
    request_error = @payload[:error]

    # Prepare message for the campfire
    message = if request_error
                "<strong>Failed</strong> request: #{request_error}"
              else
                build_message
              end

    # send message to basecamp
    helpers.send_message(message)
  end

  private

  def build_message
    # Store parsed dada from Rollbar
    event = @payload['error']['exceptionClass']
    error_message = @payload['error']['message']
    event_url = @payload['error']['url']
    message = "<strong>Event:</strong>  #{event}<br/>
              <strong>Body:</strong>  #{error_message}<br/>
              <strong>Rollbar report:</strong>  #{event_url}"
  end
end
