class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def command_params
    params.permit(:command)
  end
end
