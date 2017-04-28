class Api::Sns::MessagesController < ApplicationController

  def create
    amazon_sns_request = Chatbot.parse_webhook(request.body.read)
    snstopic_arn = Rails.configuration.service['snstopic_arn']
    aws_region = Rails.configuration.service['aws_region']
    client = Aws::SNS::Client.new(region: aws_region)

    if amazon_sns_request['Type'].to_s.casecmp('SubscriptionConfirmation') >= 0
      client.confirm_subscription(
        topic_arn: snstopic_arn,
        token: amazon_sns_request['Token']
      )
    elsif amazon_sns_request['Type'].to_s.casecmp('Notification') >= 0
      message = build_message_text amazon_sns_request
    end

    # send message to basecamp
    Chatbot.send_message(command_params[:callback_url], message)
  end

  private

  def build_message_text(amazon_sns_request)
    # Store parsed dada from amazon SNS
    subject = amazon_sns_request['Subject']
    body = amazon_sns_request['Message']
    return "<strong>Subject:</strong>  #{subject}<br/>
           <strong>Body:</strong>  #{body}<br/>"
  rescue NoMethodError => e # del. exception handlidg to see errors in console
    return "<strong>Amazon SNS parsing error:</strong>  #{e}"
  end
end
