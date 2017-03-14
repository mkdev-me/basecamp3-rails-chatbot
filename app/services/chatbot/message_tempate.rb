module Chatbot::MessageTempate
  def self.show(options)
    ActionView::Base.new(ActionController::Base.view_paths, subject: options[:subject], message: options[:message]).render(template: '/services/chatbot_message_tempate')
  end
end
