# basecamp3-rails-chatbot

Rails application to transfer messages to your basecamp3 HQ.
 
### Supported services
1. [AWS SNS](https://aws.amazon.com/sns/)
2. [Bugsnag](https://www.bugsnag.com/)
3. [GitLab](https://gitlab.com)
4. [Rollbar](https://rollbar.com)
5. [Giphy](https://giphy.com)

### Instruction

* [Create a Chatbot](#create-chatbot )
* [AWS integration](#aws-integration)
* [Bugsnag integration](#bugsnag-integration)
* [Gitlab integration](#gitlab-integration)
* [Rollbar integration](#rollbar-integration)
* [Giphy integration](#giphy-integration)
* [References](#references)

#### Create a Chatbot 

1. Register Basecamp and [create bot](https://m.signalvnoise.com/new-in-basecamp-3-chatbots-8526618c0c7d#.kabo3hgs1). There
you need a bot long link. Like this: 
    `https://3.basecamp.com/195539477/integrations/2uH9aHLEVhhaXKPaqrj8yw8P/buckets/2085958501/chats/9007199254741775/lines`
2. Clone this repo from GitHub.
    1. Run __`bundle install`__ in your project directory.
    2. Create a ```secrets.yml``` file in your config folder as described [here](http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml).
3. Add your Basecamp __bot url__ to `/config/service.yml`
4. You will probably want to try running your app locally to test it and make sure it’s working as expected. To do that you will need a service that allows you to expose a web server running on your local machine to the Internet. We recommend to try [Ngrok](http://ngrok.com).
    1. If you see this message on rails console:
        ``Cannot render console from XXX.XXX.XXX.XXX! Allowed networks: 127.0.0.1,...``
        You need to whitelist the XXX.XXX.XXX.XXX network space in the Web console config.
        Open ``config/environments/development.rb`` and type IP address of remote server:

        ``` config.web_console.whitelisted_ips = 'XXX.XXX.XXX.XXX' ```

    Read more about IP's whitelisting [here](https://github.com/rails/web-console#configweb_consolewhitelisted_ips).

#### AWS integration

1. Register AWS and [create SNS topic](http://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html). Remember Topic ARN! It looks like this:
    `arn:aws:sns:us-east-6:23730808936387:topick_name`
2. Add your SNS __Topic ARN__ to  `/config/service.yml`
3. [Aws-sdk gem](https://github.com/aws/aws-sdk-ruby), which used in this App, needs 'aws_access_key' and 'aws_secret_key' to work. To find them navigate to "My Security Credentials" category in your asw.amazon account. Always load your credentials from outside your application! Look at `/config/service.yml` for example. Avoid configuring credentials statically and never commit them to source control!
    1) If you're running on AWS EC2 you able to assign AWS keys dynamically with IAM roles.
    2. Create an IAM role.
    3. Define which AWS services can assume the role (AmazonSNSFullAccess etc.)
    4. Specify the role when you launch your instance, or attach the role to a running or stopped instance. 
4. Start  rails server by typing `rails s` command.
5. [Create subscription](http://docs.aws.amazon.com/sns/latest/dg/SubscribeTopic.html). Use HTTP **Protocol** and  `http://your-external-host/api/sns/messages` as __Endpoint__
6. At first time SNS send confirmation request which will be automatically accepted. After subscription you can [publish messages to the topic](http://docs.aws.amazon.com/sns/latest/dg/PublishTopic.html)

#### Bugsnag integration

1. Create [Bugsnag account](https://www.bugsnag.com/) and create new project.
2. Navigate to 'Integrations' menu.
3. Select the 'Webhook', enter the full URL where webhooks should be posted (http://your-external-host/api/bugsnag/messages`), choice notification events and enable the integration. 
4. For more instructions, please visit [Bugsnag docs](https://docs.bugsnag.com/api/) and [Ruby on Rails integration](https://docs.bugsnag.com/platforms/ruby/rails/)

#### Gitlab integration

1. Create [Gitlab account](https://gitlab.com) and start the New project.
2. Navigate to the project's 'Settings/Integrations' menu.
3. Select the 'Webhook', enter the full URL where webhooks should be posted (http://your-external-host/api/gitlab/messages`). Mark event checkboxes and click the 'Add Webhook' button. 
4. For more instructions, please visit [GitLab Webhooks docs](https://gitlab.com/help/user/project/integrations/webhooks).

#### Rollbar integration

1. Create [Rollbar account](https://rollbar.com) and start the New project.
2. Navigate to the project, click 'Settings', then click 'Notifications' in the left menu.
3. Select the 'Webhook', enter the full URL where webhooks should be posted (this App server) and enable the integration. 
4. Once set up, you can add, edit, or remove rules. For more instructions, please visit [Rollbar docs](https://rollbar.com/docs/webhooks) and [Ruby Integration](https://rollbar.com/docs/notifier/rollbar-gem)

#### Giphy integration

1. Add Gipy API 'search query' to `/config/service.yml`. Look at `/config/service.yml` for example.
2. If you'll send some POST request to `http://your-external-host/api/giphy/messages` Chatbot will post to your Basecamp chat a random funny gif from [Giphy](http://giphy.com/).
3. Just for fun!

#### References

* AWS-SDK [documentation](http://docs.aws.amazon.com/sdkforruby/api/Aws/SNS/Client.html)
* Giphy [Api docs](https://github.com/Giphy/GiphyAPI)