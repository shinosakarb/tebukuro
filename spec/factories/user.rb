FactoryBot.define do
  factory :user do
    name { ForgeryJa(:name).full_name }
    email { Faker::Internet.email }
  end
end
