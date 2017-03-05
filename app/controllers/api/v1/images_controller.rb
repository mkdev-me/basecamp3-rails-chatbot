class Api::V1::ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    basecampbot_url = Rails.configuration.service['basecampbot_url']

    unless request.headers['Content-Length']
      request_body = JSON.parse request.body.read
      tag = request_body['tag']
    end

    tag ||= nil

    HTTParty.post(basecampbot_url, query: { content: random_image_url(tag) })

    head :no_content
  end

  private

  def random_image_url(tag = '')
    Giphy.random(tag).instance_variable_get('@hash')
         .fetch('fixed_width_downsampled_url')
  end
end
