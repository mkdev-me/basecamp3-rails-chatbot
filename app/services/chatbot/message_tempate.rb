module Chatbot::MessageTempate
	def self.show(params)
	  ActionView::Base.new(ActionController::Base.view_paths, message_hash: params).render(template: "/services/chatbot_message_tempate")
	end
end