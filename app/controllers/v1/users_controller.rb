# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]

    # Get /v1/users
    def index
      @users = User.all
      render json: @users
    end

    # POST /v1/users
    def create
      @user = User.create!(user_params)
      render json: @user, status: :created
    end

    # GET /v1/users/:id
    def show
      render json: @user
    end

    # PUT /users/:id
    def update
      @user.update(user_params)
      head :no_content
    end

    # DELETE /users/:id
    def destroy
      @user.destroy
      head :no_content
    end

    private

    def user_params
      params.permit(
        :name,
        :email,
        :date_of_birth
      )
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
