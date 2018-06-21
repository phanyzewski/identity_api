# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StateIdentifier, type: :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:state_id_number) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:expiration_date) }
end
