FactoryBot.define do
  factory :chatroom do
    name { Faker::Lorem.unique.word }
  end
end
