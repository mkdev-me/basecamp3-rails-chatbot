require 'httparty'

class Integrations::AwsSnsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    snstopic_arn = Rails.configuration.service['snstopic_arn']

    # get amazon message type and topic
    amz_message_type = request.headers['x-amz-sns-message-type']
    amz_sns_topic = request.headers['x-amz-sns-topic-arn']

    # sure you recieve messages from a right topic
    return unless !amz_sns_topic.nil? &&
        amz_sns_topic.to_s.downcase == snstopic_arn

    request_body = JSON.parse request.body.read

    # if this is the first time confirmation of subscription, then confirm it
    if amz_message_type.to_s.downcase == 'subscriptionconfirmation'
      send_subscription_confirmation request_body
      return
    end

    if amz_message_type.to_s.downcase == 'notification'
      Chatbot.post_message(
        Rails.configuration.service['basecampbot_url'],
        {
          subject: request_body['Subject'],
          message: request_body['Message']
        }
      )
    end

    head :ok
  end

  private

  def send_subscription_confirmation(request_body)
    url = request_body['SubscribeURL']
    return nil unless url.present?
    HTTParty.get(url)
  end
end
