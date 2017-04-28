class Api::Giphy::MessagesController < ApplicationController

  def create
    image = Giphy.random(command_params[:command]).image_original_url.to_s
    Chatbot.send_message(command_params[:callback_url], "<img src='#{image}' />")
  end
end
