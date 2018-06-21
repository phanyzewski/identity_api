# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data
  let!(:users) { FactoryBot.create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:state_id) { FactoryBot.create(:state_identifier, user: users.first) }
  let(:medical_recommendation) { FactoryBot.create(:medical_recommendation, user: users.first) }

  # Test suite for GET /v1/users
  describe 'GET /v1/users' do
    # make HTTP get request before each example
    before { get '/v1/users' }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
    end

    it 'returns all users' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  # Test suite for GET /v1/users/:id
  describe 'GET /v1/users/:id' do
    before { get "/v1/users/#{user_id}" }

    context 'when the record exists' do
      it 'returns a user' do
        expect(json).not_to be_empty
      end

      it 'return the correct user' do
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for POST /v1/users
  describe 'POST /v1/users' do
    # valid payload
    let(:valid_attributes) do
      {
        name: 'Jon Snow',
        email: 'jsnow@got.com',
        date_of_birth: '1983-03-03'
      }
    end

    context 'when the request is valid' do
      before { post '/v1/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['name']).to eq('Jon Snow')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post '/v1/users', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entry)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /v1/users/:id
  describe 'PUT /v1/users/:id' do
    let(:valid_updated_attributes) do
      {
        name: 'Jon Targaryen',
        email: 'jTargaryen@got.com',
        date_of_birth: '1983-03-03'
      }
    end

    context 'when the record exists' do
      before { put "/v1/users/#{user_id}", params: valid_updated_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  # Test suite for DELETE /v1/users/:id
  describe 'DELETE /v1/users/:id' do
    before { delete "/v1/users/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
