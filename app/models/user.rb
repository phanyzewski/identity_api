# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :date_of_birth, presence: true

  has_one :state_identifier, dependent: :destroy
  has_one :medical_recommendation, dependent: :destroy
end
