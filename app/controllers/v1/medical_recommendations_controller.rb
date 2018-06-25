# frozen_string_literal: true

module V1
  class MedicalRecommendationsController < ApplicationController
    before_action :set_recommendation, only: %i[show update destroy]

    # Get /v1/users/:id/medical_recommendations
    def index
      @recommendations = MedicalRecommendation.where(user_id: params[:user_id])
      json_string = MedicalRecommendationSerializer.new(@recommendations).serialized_json
      render json: json_string
    end

    # POST /v1/users/:id/medical_recommendations
    def create
      @medical_recommendation = MedicalRecommendation.create!(recommendation_params)
      store_image if recommendation_params.include?(:identification_card)
      json_string = MedicalRecommendationSerializer.new(@medical_recommendation).serialized_json
      render json: json_string, status: :created
    end

    # GET /v1/users/:id/medical_recommendations/:id
    def show
      json_string = MedicalRecommendationSerializer.new(@medical_recommendation).serialized_json
      render json: json_string
    end

    # PUT /v1/users/:id/medical_recommendations/:id
    def update
      @medical_recommendation.update(recommendation_params)
      store_image if recommendation_params.include?(:identification_card)
      head :no_content
    end

    # DELETE /v1/users/:id/medical_recommendations/:id
    def destroy
      @medical_recommendation.destroy
      head :no_content
    end

    private

    def recommendation_params
      params.permit(
        :user_id,
        :medical_recommendation_number,
        :issuer,
        :state,
        :expiration_date,
        :identification_card
      )
    end

    def set_recommendation
      @medical_recommendation = MedicalRecommendation.find_by!(id: params[:id], user: params[:user_id])
    end

    def store_image
      @medical_recommendation.identification_card.purge if @medical_recommendation.identification_card.attached?
      @medical_recommendation.identification_card.attach(params[:identification_card])
      @medical_recommendation.image_url = url_for(@medical_recommendation.identification_card)
      @medical_recommendation.save
    end
  end
end
