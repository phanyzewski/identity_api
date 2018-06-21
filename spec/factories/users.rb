# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    date_of_birth { Faker::Date.birthday(18, 65) }
  end
end
