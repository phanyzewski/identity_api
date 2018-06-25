# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :date_of_birth, :email

  has_one :state_identifier
  has_one :medical_recommendation
end
