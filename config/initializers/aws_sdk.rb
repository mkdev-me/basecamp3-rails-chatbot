aws_secret_file = Rails.configuration.service['aws_secret_file']
creds = YAML.load(File.read(aws_secret_file))
  aws_creds = Aws::Credentials.new(
    creds['aws_access_key'],
    creds['aws_secret_key']
  )
  # Configure and create an AWS_SNS client
Aws.config.update(region: creds['aws_region'], credentials: aws_creds)