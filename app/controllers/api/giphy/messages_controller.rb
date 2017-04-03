class Api::Giphy::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    image = Giphy.random(command_params[:command]).image_original_url.to_s
    helpers.send_message(command_params[:callback_url], "<img src='#{image}' />")
  end
end
