require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  describe 'validations' do
    subject(:room) { build(:chatroom) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(30) }
  end

  describe 'associations' do
    subject(:room) { build(:chatroom) }

    it { should have_many(:messages).dependent(:destroy) }
  end
end
