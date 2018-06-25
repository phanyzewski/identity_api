# frozen_string_literal: true

class StatusController < ApplicationController
  def index
    render json: {
      app:     'users_api',
      status:  'OK'
    }
  end
end
