# frozen_string_literal: true

class StateIdentifier < ApplicationRecord
  belongs_to :user
  has_one_attached :identification_card

  validates :state_id_number, presence: true
  validates :state, presence: true
  validates :expiration_date, presence: true

  def expired
    # NOTE: Might want to consider adding zipcode to get an accurate timezone for this function
    expiration_date < Date.current
  end
end
