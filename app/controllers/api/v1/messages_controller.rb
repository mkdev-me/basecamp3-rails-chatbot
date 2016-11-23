require 'json'
require 'httparty'

class Api::V1::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # get amazon message type and topic
    amz_message_type = request.headers['x-amz-sns-message-type']
    amz_sns_topic = request.headers['x-amz-sns-topic-arn']

    #sure you recieve messages from a right topic
    return unless !amz_sns_topic.nil? &&
        amz_sns_topic.to_s.downcase == 'arn:aws:sns:eu-central-1:798348585423:basecamp-bot'

    request_body = JSON.parse request.body.read

    # if this is the first time confirmation of subscription, then confirm it
    if amz_message_type.to_s.downcase == 'subscriptionconfirmation'
      send_subscription_confirmation request_body
      return
    end

    if amz_message_type.to_s.downcase == 'notification'
      #DO WORK HERE
      puts "Subject: #{request_body['Subject']}. Message: #{request_body['Message']}"
    end

    head :ok
  end

  private

  def send_subscription_confirmation(request_body)
    subscribe_url = request_body['SubscribeURL']
    return nil unless !subscribe_url.to_s.empty? && !subscribe_url.nil?
    subscribe_confirm = HTTParty.get subscribe_url
  end


end
