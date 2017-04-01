module ApplicationHelper
  def aws_config
    snstopic_arn = Rails.configuration.service['snstopic_arn']
    aws_secret_file = Rails.configuration.service['aws_secret_file']
    creds = JSON.load(File.read aws_secret_file)

    # Configure and create an AWS_SNS client
    Aws.config.update({
      region: creds['aws_region'],
      credentials: Aws::Credentials.new(creds['aws_access_key'], creds['aws_secret_key'])
    })

    client = Aws::SNS::Client.new
  end

  def parse_webhook
    # Parse JSON request from remote calback server
    JSON.parse request.body.read
  # Handle exceptions in case of failed request
  rescue JSON::ParserError => error
    return { error: error.to_s }
  end

  def send_message(message)
    # Send message to Basecamp Campfire via ChatBot
    basecampbot_url = Rails.configuration.service['basecampbot_url']
    HTTParty.post basecampbot_url, query: { content: message }
  end
end
