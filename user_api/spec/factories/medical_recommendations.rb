# frozen_string_literal: true

FactoryBot.define do
  factory :medical_recommendation do
    association :user, strategy: :create

    medical_recommendation_number 123_456
    issuer { Faker::FunnyName.name }
    state 'Alaska'
    expiration_date { Faker::Date.forward(3) }
  end
end
