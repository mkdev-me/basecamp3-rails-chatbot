Giphy::Configuration.configure do |config|
  config.api_key = Rails.configuration.service['giphy_api_key']
end
