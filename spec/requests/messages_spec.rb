require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "GET /create" do
     let(:user) { create(:user) }
     let(:chatroom) { create(:chatroom, name: 'general') }
     let(:membership) { create(:membership, user: user, chatroom: chatroom) }

     before do
       sign_in user
       membership
     end

    let(:content) { 'hello world' }
    let(:params) do
      {
        message: {
          content: content
        }
      }
    end

    subject(:post_message) do
      post chatroom_messages_path(chatroom), params: params
    end

    it 'creates a new record' do
      expect do
        post_message
      end.to change(Message, :count).by(1)
    end


    it 'return success' do
      post_message
      expect(response).to have_http_status(:ok)
    end

    context 'when content is invalid' do
      let(:content) { 'a' * 1002 }

      it 'return unprocessable_entity when content is invalid' do
        post_message
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
