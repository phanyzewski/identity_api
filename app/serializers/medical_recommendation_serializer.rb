# frozen_string_literal: true

class MedicalRecommendationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :medical_recommendation_number, :issuer, :state, :expiration_date, :expired, :image_url
end
