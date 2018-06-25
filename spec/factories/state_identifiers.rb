# frozen_string_literal: true

FactoryBot.define do
  factory :state_identifier do
    association :user, strategy: :create

    state_id_number 123_456
    state 'Alaska'
    expiration_date { Faker::Date.forward(3) }

    trait :expired do
      expiration_date { Faker::Date.backward(3) }
    end
  end
end
