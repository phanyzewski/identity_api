# frozen_string_literal: true

class StateIdentifierSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :state_id_number, :state, :expiration_date, :expired, :image_url
end
