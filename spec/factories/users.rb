FactoryBot.define do
  factory :user do
		account { Faker::Name.account }
    email { Faker::Internet.email }
    password { 'password' }
  end
end