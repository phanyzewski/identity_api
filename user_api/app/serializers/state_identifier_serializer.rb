# frozen_string_literal: true

class StateIdentifierSerializer < ActiveModel::Serializer
  attributes :id, :state_id_number, :state, :expiration_date, :expired
end
