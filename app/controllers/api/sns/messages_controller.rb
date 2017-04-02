class Api::Sns::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    amazon_sns_request = helpers.parse_webhook
    snstopic_arn = Rails.configuration.service['snstopic_arn']
    client = helpers.aws_config
    
    if amazon_sns_request['Type'].to_s.downcase == "subscriptionconfirmation"
      resp = client.confirm_subscription({
      topic_arn: snstopic_arn,
      token: amazon_sns_request['Token'],
      })
    elsif amazon_sns_request['Type'].to_s.downcase == "notification"
      message = build_message_text amazon_sns_request
    end

    # send message to basecamp
    helpers.send_message(message)
  end

  private

  def build_message_text(amazon_sns_request)
    # Store parsed dada from amazon SNS
    subject = amazon_sns_request['Subject']
    body = amazon_sns_request['Message']
    return "<strong>Subject:</strong>  #{subject}<br/>
           <strong>Body:</strong>  #{body}<br/>"
  rescue NoMethodError => error # remove exception handlidg to see errors in the Dev. console
    return "<strong>Amazon SNS parsing error:</strong>  #{error}"
  end
end
