FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }
    association :user
    association :chatroom
  end
end
