# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'State Identifier API', type: :request do
  # initialize test data
  let!(:user) { FactoryBot.create(:user) }
  let(:user_id) { user.id }
  let(:state_id) { FactoryBot.create(:state_identifier, user: user) }

  before do
    user.update(state_identifier: state_id)
  end

  # Test suite for GET /v1/state_identifiers
  describe 'GET /v1/state_identifiers' do
    # make HTTP get request before each example
    before { get '/v1/state_identifiers' }

    it 'returns status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end

  # Test suite for GET /v1/users/:id/state_identifiers/:id
  describe 'GET /v1/users/:id/state_identifiers' do
    before { get "/v1/users/#{user_id}/state_identifiers" }

    context 'when the record exists' do
      it 'returns an identifier' do
        expect(json).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the state id does not exist' do
      before do
        user.state_identifier.delete
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find State Identifier/)
      end
    end
  end

  # Test suite for POST /v1/users/:id/state_identifiers
  describe 'POST /v1/users/:id/state_identifiers' do
    # valid payload
    let(:valid_attributes) do
      {
        # user: user,
        state_id_number: 123,
        state: 'Alaska',
        expiration_date: '2023-03-03'
      }
    end

    context 'when the request is valid' do
      before { post "/v1/users/#{user_id}/state_identifiers", params: valid_attributes }

      it 'creates a state identifier' do
        expect(json['state_id_number']).to eq(123)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post "/v1/users/#{user_id}/state_identifiers", params: { state_id_number: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entry)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /v1/state_identifiers/:id
  describe 'PUT /v1/users/:id/state_identifiers/:id' do
    let(:valid_updated_attributes) do
      {
        # user: user,
        state_id_number: 123,
        state: 'Alaska',
        expiration_date: '2023-03-03'
      }
    end

    context 'when the record exists' do
      before { put "/v1/users/#{user_id}/state_identifiers/#{state_id.id}", params: valid_updated_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  # Test suite for DELETE /v1/state_identifiers/:id
  describe 'DELETE /v1/users/:id/state_identifiers/:id' do
    before { delete "/v1/users/#{user_id}/state_identifiers/#{state_id.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
