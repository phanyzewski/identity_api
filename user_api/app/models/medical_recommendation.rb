# frozen_string_literal: true

class MedicalRecommendation < ApplicationRecord
  belongs_to :user

  validates :medical_recommendation_number, presence: true
  validates :issuer, presence: true
  validates :state, presence: true
  validates :expiration_date, presence: true

  def expired
    # NOTE: Might want to consider adding zipcode to get an accurate timezone for this function
    expiration_date < Date.current
  end
end
