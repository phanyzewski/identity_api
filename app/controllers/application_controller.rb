# frozen_string_literal: true

class ApplicationController < ActionController::API
  include RenderResponse
  include ExceptionHandler
end
