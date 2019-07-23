FactoryBot.define do
  factory :user do
    surname { FFaker::Name.last_name }
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { "123456" }
    encrypted_password { BCrypt::Password.create(password) }
  end
end
