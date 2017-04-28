class Api::Bugsnag::MessagesController < ApplicationController

  def create
    # Get the parsed JSON string
    bugsnag_parsed = Chatbot.parse_webhook(request.body.read)

    # error: JSON:ParserError
    # Get the failed JSON request message
    request_error = bugsnag_parsed[:error]

    # Prepare message for the campfire
    message = if request_error
                "<strong>Failed or non-JSON request:</strong> #{request_error}"
              else
                build_message_text bugsnag_parsed
              end

    # send message to basecamp
    Chatbot.send_message(command_params[:callback_url], message)
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
  rescue NoMethodError => e # del. exception handlidg to see errors in console
    return "<strong>Bugsnag parsing error:</strong>  #{e}"
  end
end
