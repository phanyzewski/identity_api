# frozen_string_literal: true

FactoryBot.define do
  factory :medical_recommendation do
    association :user, strategy: :create

    medical_recommendation_number 123_456
    issuer { Faker::FunnyName.name }
    state 'Alaska'
    expiration_date { Faker::Date.forward(3) }

    trait :expired do
      expiration_date { Faker::Date.backward(3) }
    end

    trait :new_card do
      identification_card {
        File.open(
          Rails.root.join('spec', 'factories', 'images', 'mmic.png'), filename: 'mmic.png', content_type: 'image/png'
        )
      }
    end
  end
end
