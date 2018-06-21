# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Medical Recommendations API', type: :request do
  # initialize test data
  let!(:user) { FactoryBot.create(:user) }
  let(:user_id) { user.id }
  let(:medical_recommendation) { FactoryBot.create(:medical_recommendation, user: user) }
  let(:recommendation_id) { recommendation_id }

  before do
    user.update(medical_recommendation: medical_recommendation)
  end

  # Test suite for GET /v1/medical_recommendation
  describe 'GET /v1/medical_recommendation' do
    # make HTTP get request before each example
    before { get '/v1/medical_recommendation' }

    it 'returns status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end

  # Test suite for GET /v1/users/:id/medical_recommendation/:id
  describe 'GET /v1/users/:id/medical_recommendation' do
    before { get "/v1/users/#{user_id}/medical_recommendation" }

    context 'when the record exists' do
      it 'returns an identifier' do
        expect(json).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the medical_recommendation does not exist' do
      before do
        user.medical_recommendation.delete
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Medical Recommendation/)
      end
    end
  end

  # Test suite for POST /v1/users/:id/medical_recommendation
  describe 'POST /v1/users/:id/medical_recommendation' do
    # valid payload
    let(:valid_attributes) do
      {
        # user: user,
        medical_recommendation_number: 123,
        issuer: 'person',
        state: 'Alaska',
        expiration_date: '2023-03-03'
      }
    end

    context 'when the request is valid' do
      before { post "/v1/users/#{user_id}/medical_recommendation", params: valid_attributes }

      it 'creates a medical_recommendation' do
        expect(json['medical_recommendation_number']).to eq(123)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post "/v1/users/#{user_id}/medical_recommendation", params: { medical_recommendation_number: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entry)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /v1/medical_recommendation/:id
  describe 'PUT /v1/users/:id/medical_recommendation/:id' do
    let(:updated_attributes) do
      {
        # user: user,
        medical_recommendation_number: 123,
        issuer: 'person',
        state: 'Alaska',
        expiration_date: '2023-03-03'
      }
    end

    context 'when the record exists' do
      before { put "/v1/users/#{user_id}/medical_recommendation/#{recommendation_id}", params: updated_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  # Test suite for DELETE /v1/medical_recommendation/:id
  describe 'DELETE /v1/users/:id/medical_recommendation/:id' do
    before { delete "/v1/users/#{user_id}/medical_recommendation/#{recommendation_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
