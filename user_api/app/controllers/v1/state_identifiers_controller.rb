# frozen_string_literal: true

module V1
  class StateIdentifiersController < ApplicationController
    before_action :set_identifier, only: %i[show update destroy]

    # Get /v1/users/:id/users
    def index
      @identifiers = StateIdentifier.where(user_id: params[:user_id])
      render_response(@identifiers)
    end

    # POST /v1/users/:id/state_identifiers
    def create
      @state_identifier = StateIdentifier.create!(identifier_params)
      render_response(@state_identifier, :created)
    end

    # GET /v1/users/:id/state_identifiers/:id
    def show
      json_string = StateIdentifierSerializer.new(@state_identifier).attributes
      render_response(json_string)
    end

    # PUT /v1/users/:id/state_identifiers/:id
    def update
      @state_identifier.update(identifier_params)
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
        :expiration_date
      )
    end

    def set_identifier
      @state_identifier = StateIdentifier.find_by!(id: params[:id], user: params[:user_id])
    end
  end
end
