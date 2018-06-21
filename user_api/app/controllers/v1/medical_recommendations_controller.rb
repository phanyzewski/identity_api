# frozen_string_literal: true

module V1
  class MedicalRecommendationsController < ApplicationController
    before_action :set_recommendation, only: %i[show update destroy]

    # Get /v1/users/:id/medical_recommendations
    def index
      @recommendations = MedicalRecommendation.where(user_id: params[:user_id])
      render_response(@recommendations)
    end

    # POST /v1/users/:id/medical_recommendations
    def create
      @medical_recommendation = MedicalRecommendation.create!(recommendation_params)
      render_response(@medical_recommendation, :created)
    end

    # GET /v1/users/:id/medical_recommendations/:id
    def show
      json_string = MedicalRecommendationSerializer.new(@medical_recommendation).attributes
      render_response(json_string)
    end

    # PUT /v1/users/:id/medical_recommendations/:id
    def update
      @medical_recommendation.update(recommendation_params)
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
        :expiration_date
      )
    end

    def set_recommendation
      @medical_recommendation = MedicalRecommendation.find_by!(id: params[:id], user: params[:user_id])
    end
  end
end
