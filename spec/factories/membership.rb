FactoryBot.define do
  factory :membership do
    association :user
    association :chatroom
  end
end
