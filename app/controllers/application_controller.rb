class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?
  
  private

  def json_request?
    request.format.json?
  end

  def command_params
    params.permit(:command, :callback_url)
  end
end
