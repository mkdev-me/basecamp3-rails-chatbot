require 'rails_helper'

describe Api::V1::MessagesController do

  describe 'POST #create' do  	
  	before(:each) do
  	  post :create
  	end
    context 'when AWS SNS send confirmation request' do  	  
  	  it "goes to SubscriptionURL" do
  	    expect(response.status).to eql(204)
  	  end
    end
    context 'when AWS SNS send notification' do
      it 'posts to Basecamp' do

      end
    end
  end

end
