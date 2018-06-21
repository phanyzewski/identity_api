# frozen_string_literal: true

class MedicalRecommendationSerializer < ActiveModel::Serializer
  attributes :id, :medical_recommendation_number, :issuer, :state, :expiration_date, :expired
end
