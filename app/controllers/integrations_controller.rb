require 'json'
require 'httparty'

class IntegrationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def rollbar
    basecampbot_url = Rails.configuration.service['basecampbot_url']
    request_body = JSON.parse request.body.read

    event = request_body['event_name']
    app = request_body['data']['item']['last_occurrence']['request']['headers']['Host']
    title = request_body['data']['item']['title']
    uuid = request_body['data']['item']['last_occurrence']['uuid']
    link = 'https://rollbar.com/item/uuid/?uuid=' + uuid

    message = "Project: #{ app }. Event: #{ event }<br/> " +
              "Error: #{ view_context.link_to(title, link, target: '_blank') } "

    # send message to basecamp
    HTTParty.post basecampbot_url, query: { content: message }

    head :ok
  end
end
