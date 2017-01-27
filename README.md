# basecamp3-rails-chatbot

Rails application to transfer messages to your basecamp3 HQ.
 
## Supported services
1. [AWS SNS](https://aws.amazon.com/sns/)

## Usage

1. Register AWS and [create SNS topic](http://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html). Remember Topic ARN!
2. Register Basecamp and [create bot](https://m.signalvnoise.com/new-in-basecamp-3-chatbots-8526618c0c7d#.kabo3hgs1). There
you need a bot long link. Like this: `https://3.basecamp.com/195539477/integrations/2uH9aHLEVhhaXKPaqrj8yw8P/buckets/2085958501/chats/9007199254741775/lines`
3. Clone this repo && bundle install
4. Write your SNS **Topic ARN** and Basecamp **bot url** to /config/service.yml
5. rails s
6. [Create subscription](http://docs.aws.amazon.com/sns/latest/dg/SubscribeTopic.html). Use HTTP **Protocol** and 
`http://your-external-host/api/v1/messages` as **Endpoint**
7. At first time SNS send confirmation request. After subscription you can 
[publish messages to a topic](http://docs.aws.amazon.com/sns/latest/dg/PublishTopic.html)

## Local usage

In case of use this application on localhost you may need to make port mapping.
Then you need to install a [ngrok](https://ngrok.com/) or [local tunnel](https://localtunnel.github.io/www/) and start it `./ngrok http 3000` or `lt --port 3000`.
You also could have to insert
```ruby
config.web_console.whitelisted_ips = '0.0.0.0/0' # or fixed zone
```
to your /config/enviroments/development.rb

## References

* Most controller logic based on [Creating SNS subscription endpoints with Ruby on Rails](http://blog.eng.xogrp.com/post/79166302844/creating-sns-subscription-endpoints-with-ruby-on#disqus_thread)