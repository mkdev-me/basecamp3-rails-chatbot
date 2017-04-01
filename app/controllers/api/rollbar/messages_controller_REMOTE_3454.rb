class Api::Rollbar::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Get the parsed JSON string
    rollbar_parsed = helpers.parse_webhook

    # error: JSON:ParserError
    # Get the failed JSON request message
    request_error = rollbar_parsed[:error]

    # Prepare message for the campfire
    message = if request_error
                "<strong>Failed or 'non JSON' request:</strong> #{request_error}"
              else
                build_message_text rollbar_parsed
              end

    # send message to basecamp
    helpers.send_message(message)
  end

  private

  def build_message_text(rollbar_parsed)
    # Store parsed dada from Rollbar
    event = rollbar_parsed['event_name']
    data = rollbar_parsed['data']['item']['title']
    uuid = rollbar_parsed['data']['occurrence']['uuid']
    event_url = "https://rollbar.com/instance/uuid?uuid=#{uuid}"
    return "<strong>Event:</strong>  #{event}<br/>
           <strong>Body:</strong>  #{data}<br/>
           <strong>Rollbar report:</strong>  #{event_url}"
  rescue NoMethodError => error # remove exception handlidg to see errors in the Dev. console
    return "<strong>Rollbar parsing error:</strong>  #{error}"
  end
end
