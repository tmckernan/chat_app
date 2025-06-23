require 'rails_helper'

RSpec.describe Membership, type: :model do
  describe 'associations' do
    subject(:membership) { build(:membership) }

    it { should belong_to(:user) }
    it { should belong_to(:chatroom) }
  end
end
