# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Medical Recommendations API', type: :request do
  # initialize test data
  let!(:user) { FactoryBot.create(:user) }
  let(:user_id) { user.id }
  let(:medical_recommendation) { FactoryBot.create(:medical_recommendation, user: user) }
  let(:recommendation_id) { medical_recommendation.id }

  before do
    user.update(medical_recommendation: medical_recommendation)
  end

  # Test suite for GET /v1/users/:id/medical_recommendation
  describe 'GET /v1/users/:id/medical_recommendation' do
    # make HTTP get request before each example
    before { get "/v1/users/#{user_id}/medical_recommendations" }

    it 'returns medical_recommendations' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  # Test suite for GET /v1/users/:id/medical_recommendation/:id
  describe 'GET /v1/users/:id/medical_recommendations' do
    before { get "/v1/users/#{user_id}/medical_recommendations/#{recommendation_id}" }

    context 'when the record exists' do
      it 'returns an identifier' do
        expect(json.dig('data', 'id')).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the medical_recommendation does not exist' do
      let(:recommendation_id) { -1 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find MedicalRecommendation/)
      end
    end
  end

  # Test suite for POST /v1/users/:id/medical_recommendation
  describe 'POST /v1/users/:id/medical_recommendations' do
    # valid payload
    let(:valid_attributes) do
      {
        medical_recommendation_number: 123,
        issuer: 'person',
        state: 'Alaska',
        expiration_date: '2023-03-03'
      }
    end

    context 'when the request is valid' do
      before { post "/v1/users/#{user_id}/medical_recommendations", params: valid_attributes }

      it 'creates a medical_recommendation' do
        expect(json.dig('data', 'attributes', 'medical_recommendation_number')).to eq(123)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before do
        post "/v1/users/#{user_id}/medical_recommendations", params: { medical_recommendation_number: 'Foobar' }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Issuer can't be blank, State can't be blank, Expiration date can't be blank/)
      end
    end
  end

  # Test suite for PUT /v1/medical_recommendation/:id
  describe 'PUT /v1/users/:id/medical_recommendations/:id' do
    let(:file) { fixture_file_upload(Rails.root.join('spec', 'factories', 'images', 'mmic.png'), 'image/png') }
    let(:updated_attributes) do
      {
        # user: user,
        medical_recommendation_number: 123,
        issuer: 'person',
        state: 'Alaska',
        expiration_date: '2023-03-03',
        identification_card: file
      }
    end

    context 'when the record exists' do
      let(:post) { put "/v1/users/#{user_id}/medical_recommendations/#{recommendation_id}", params: updated_attributes }

      it 'updates the record' do
        post
        expect(response.body).to be_empty
      end

      it 'attaches the uploaded file' do
        expect { post }.to change { medical_recommendation.reload.identification_card.attached? }.from(false).to(true)
      end

      it 'returns status code 204' do
        post
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  # Test suite for DELETE /v1/medical_recommendation/:id
  describe 'DELETE /v1/users/:id/medical_recommendations/:id' do
    before { delete "/v1/users/#{user_id}/medical_recommendations/#{recommendation_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end

  # Test for expired medical_recommendations card
  describe 'GET /v1/users/:id/medical_recommendations' do
    before do
      get "/v1/users/#{user_id}/medical_recommendations/#{recommendation_id}"
    end

    context 'when the identificaiton card is expired' do
      let(:medical_recommendation) { FactoryBot.create(:medical_recommendation, :expired, user: user) }
      let(:recommendation_id) { medical_recommendation.id }

      it 'parameter expired is true' do
        expect(json.dig('data', 'attributes', 'expired')).to be true
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the identificaiton card is not expired' do
      it 'parameter expired is false' do
        expect(json.dig('data', 'attributes', 'expired')).to be false
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
