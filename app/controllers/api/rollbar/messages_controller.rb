class Api::Rollbar::MessagesController < ApplicationController
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
    event = @payload['event_name']
    data = @payload['data']['item']['title']
    uuid = @payload['data']['occurrence']['uuid']
    event_url = "https://rollbar.com/instance/uuid?uuid=#{uuid}"
    message = "<strong>Event:</strong>  #{event}<br/> 
               <strong>Body:</strong>  #{data}<br/>
               <strong>Rollbar report:</strong>  #{event_url}"
  end
end
