class Api::Bugsnag::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Get the parsed JSON string
    bugsnag_parsed = helpers.parse_webhook

    # error: JSON:ParserError
    # Get the failed JSON request message
    request_error = bugsnag_parsed[:error]

    # Prepare message for the campfire
    message = if request_error
                "<strong>Failed or 'non JSON' request:</strong> #{request_error}"
              else
                build_message_text bugsnag_parsed
              end

    # send message to basecamp
    helpers.send_message(message)
  end

  private

  def build_message_text(bugsnag_parsed)
    # Store parsed dada from Bugsnag
    event = bugsnag_parsed['error']['exceptionClass']
    error_message = bugsnag_parsed['error']['message']
    event_url = bugsnag_parsed['error']['url']
    return "<strong>Event:</strong>  #{event}<br/>
           <strong>Message:</strong>  #{error_message}<br/>
           <strong>Bugsnag report:</strong>  #{event_url}"
  rescue NoMethodError => error # remove exception handlidg to see errors in the Dev. console
    return "<strong>Bugsnag parsing error:</strong>  #{error}"
  end
end
