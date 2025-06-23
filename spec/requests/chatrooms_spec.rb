require 'rails_helper'

RSpec.describe "Chatrooms", type: :request do
 let(:user) { create(:user) }

  describe "GET /index" do
    context 'when user not logged in' do
      it 'redirects user back to login page' do
        get chatrooms_path
       expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is logged in' do
      before do
        sign_in user
      end

      it "returns a success response" do
        get chatrooms_path
        expect(response).to be_successful
      end
    end
  end

  describe "POST /create" do
    before do
      sign_in user
    end

    let(:name) { 'general' }

    let(:params) do
      {
        chatroom: {
          name: name
        }
      }
    end

    subject(:post_create) do
      post chatrooms_path, params: params
    end

    it 'creates a new record' do
      expect do
        post_create
      end.to change(Chatroom, :count).by(1)
    end

    it 'redirects user back to newly created chatroom' do
      post_create
      expect(response).to redirect_to(chatroom_path(Chatroom.find_by(name: name)))
    end

    context 'when attempting to create an chatroom with a duplicate name' do
      let(:chatroom) { create(:chatroom, name: 'general') }

      before do
        chatroom
      end

      it 'rendered the index page' do
        post_create
        expect(response).to render_template(:index)
      end

      it 'returns an unprocessable_entity status' do
        post_create
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


  describe "POST /join_chatroom" do
    let(:chatroom) { create(:chatroom, name: 'general') }

    before do
      sign_in user
    end

    subject(:join_chatroom) do
      post join_chatroom_path(chatroom)
    end

    it 'creates a new record' do
      expect do
        join_chatroom
      end.to change(Membership, :count).by(1)
    end

    it 'redirects user back to newly created chatroom' do
      join_chatroom
      expect(response).to redirect_to(chatroom_path(chatroom))
      expect(flash[:notice]).to eq "You have joined '#{chatroom.name}'."
    end

    context 'when user is already in the chatroom' do
      let(:membership) { create(:membership, user: user, chatroom: chatroom) }

      before do
        membership
      end

      it 'return alert message' do
        join_chatroom
        expect(response).to redirect_to(chatroom_path(chatroom))
        expect(flash[:alert]).to eq "You are already a member of '#{chatroom.name}'."
      end
    end
  end

  describe "POST /leave" do
    let(:chatroom) { create(:chatroom, name: 'general') }
    let(:membership) { create(:membership, user: user, chatroom: chatroom) }

    before do
      sign_in user
    end

    subject(:leave_chatroom) do
      delete leave_chatroom_path(chatroom)
    end

    it 'delete record' do
      membership
      expect do
        leave_chatroom
      end.to change(Membership, :count).by(-1)
    end

    it 'not in the chatroom' do
      leave_chatroom
      expect(response).to redirect_to(chatrooms_path)
      expect(flash[:alert]).to eq "You are not a member of '#{chatroom.name}'."
    end
  end
end
