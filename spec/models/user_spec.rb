require 'rails_helper'

describe 'validations' do
  subject(:user) { build(:user) }

  it { should validate_presence_of(:display_name) }
  it { should validate_uniqueness_of(:display_name).case_insensitive }
  it { should validate_length_of(:display_name).is_at_least(3).is_at_most(20) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value('user@example.com').for(:email) }
  it { should_not allow_value('userexample.com').for(:email) }
end

describe 'associations' do
  subject(:user) { build(:user) }

  it { is_expected.to have_many(:messages) }
end
