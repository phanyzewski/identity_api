# frozen_string_literal: true

module V1
  class StateIdentifiersController < ApplicationController
    before_action :set_identifier, only: %i[show update destroy]

    # Get /v1/users/:id/users
    def index
      @identifiers = StateIdentifier.where(user_id: params[:user_id])
      render json: @identifiers
    end

    # POST /v1/users/:id/state_identifiers
    def create
      @state_identifier = StateIdentifier.create!(identifier_params)
      render json: @state_identifier, status: :created
    end

    # GET /v1/users/:id/state_identifiers/:id
    def show
      json_string = StateIdentifierSerializer.new(@state_identifier).attributes
      render json: json_string
    end

    # PUT /v1/users/:id/state_identifiers/:id
    def update
      @state_identifier.update(identifier_params)
      store_image if identifier_params.include?(:identification_card)
      head :no_content
    end

    # DELETE /v1/users/:id/state_identifiers/:id
    def destroy
      @state_identifier.destroy
      head :no_content
    end

    private

    def identifier_params
      params.permit(
        :user_id,
        :state_id_number,
        :state,
        :expiration_date,
        :identification_card
      )
    end

    def set_identifier
      @state_identifier = StateIdentifier.find_by!(id: params[:id], user: params[:user_id])
    end

    def store_image
      @state_identifier.identification_card.purge if @state_identifier.identification_card.attached?
      @state_identifier.identification_card.attach(params[:identification_card])
      @state_identifier.image_url = url_for(@state_identifier.identification_card)
    end
  end
end
