require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    subject(:message) { build(:message) }
    it { should validate_presence_of(:content) }
  end

  describe 'associations' do
    subject(:message) { build(:message) }

    it { should belong_to(:user) }
    it { should belong_to(:chatroom) }
  end
end
