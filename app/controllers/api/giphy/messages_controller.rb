class Api::Giphy::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    giphy_url = Rails.configuration.service['giphy_url']
    giphy_parsed = JSON.parse HTTParty.get(giphy_url).body
    giphy_response_status = giphy_parsed['meta']['msg']
  
    if giphy_response_status == 'OK'
      message = giphy_parsed['data']['fixed_width_downsampled_url']    
    else
      message = "<strong>There's a problem with Gliphy API:</strong> response status = #{giphy_response_status}"
    end

    # send message to basecamp
    helpers.send_message(message)
  end
end
