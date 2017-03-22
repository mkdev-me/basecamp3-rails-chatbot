# basecamp3-rails-chatbot

Rails application to transfer messages to your basecamp3 HQ.
 
## Supported services
1. [AWS SNS](https://aws.amazon.com/sns/)

## Usage

1. Register AWS and [create SNS topic](http://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html). Remember Topic ARN! It looks like this:
    `arn:aws:sns:us-east-6:23730808936387:topick_name`
2. Register Basecamp and [create bot](https://m.signalvnoise.com/new-in-basecamp-3-chatbots-8526618c0c7d#.kabo3hgs1). There
you need a bot long link. Like this: 
    `https://3.basecamp.com/195539477/integrations/2uH9aHLEVhhaXKPaqrj8yw8P/buckets/2085958501/chats/9007199254741775/lines`
3. Clone this repo from GitHub.
    1. Run __`bundle install`__ in your project directory.
    2. Create a ```secrets.yml``` file in your config folder as described [here](http://guides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml).
4. Write your SNS **Topic ARN** and Basecamp **bot url** to /config/service.yml
5. Start  rails server by typing `rails s` command.
6. [Create subscription](http://docs.aws.amazon.com/sns/latest/dg/SubscribeTopic.html). Use HTTP **Protocol** and  `http://your-external-host/api/v1/messages` as **Endpoint**
7. You will probably want to try running your app locally to test it and make sure it’s working as expected. To do that you will need a service that allows you to expose a web server running on your local machine to the Internet. We recommend to try [Ngrok](http://ngrok.com).
    1. If you see this message on rails console:
        ``Cannot render console from XXX.XXX.XXX.XXX! Allowed networks: 127.0.0.1,...``
        You need to whitelist the XXX.XXX.XXX.XXX network space in the Web console config.
        Open ``config/environments/development.rb`` and type your local IP address from the Internet Service Provider:

        ``` config.web_console.whitelisted_ips = 'XXX.XXX.XXX.XXX' ```

    Read more about IP's whitelisting [here](https://github.com/rails/web-console#configweb_consolewhitelisted_ips).

8. At first time SNS send confirmation request. After subscription you can 
[publish messages to a topic](http://docs.aws.amazon.com/sns/latest/dg/PublishTopic.html)

## References

* Most controller logic based on [Creating SNS subscription endpoints with Ruby on Rails](http://blog.eng.xogrp.com/post/79166302844/creating-sns-subscription-endpoints-with-ruby-on#disqus_thread)
