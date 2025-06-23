FactoryBot.define do
  factory :user do
    display_name { Faker::Name.unique.name[0, 20] }
    email { Faker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }
  end
end
