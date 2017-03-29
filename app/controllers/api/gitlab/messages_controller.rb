class Api::Gitlab::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Get the parsed JSON string
    @payload = helpers.parse_webhook

    # error: JSON:ParserError
    # Get the failed JSON request message
    request_error = @payload[:error]

    # Prepare message for the campfire
    message = if request_error
                "<strong>Failed request:</strong> #{request_error}"
              else
                build_message
              end

    # send message to basecamp
    helpers.send_message(message)
  end

  private

  def build_message
    # Store parsed dada from Rollbar
    project_name = @payload['project']['name']
    event = @payload['object_kind']
    project_url = @payload['project']['web_url']
    return "<strong>Project:</strong>  #{project_name}<br/>
           <strong>Event:</strong>  #{event}<br/>
           <strong>Project url:</strong>  #{project_url}"
  rescue NoMethodError => error
    return "<strong>Error parsing GitLab issue:</strong>  #{error}"
  end
end
