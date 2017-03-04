require 'rails_helper'

describe Api::V1::ImagesController, type: :controller do
  describe 'POST #create' do
    context 'when anybody send request with tag' do
      it 'posts tagged image to Basecamp' do
        post :create, body: { tag: 'ball' }.to_json
        expect(response.status).to eql(204)
      end
    end

    context 'when anybody send empty post request' do
      it 'has to post random image to Basecamp' do
        post :create, body: {}.to_json
        expect(response.status).to eql(204)
      end
    end
  end
end
