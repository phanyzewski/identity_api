# frozen_string_literal: true

module RenderResponse
  def render_response(object, status = :ok)
    render json: object, status: status
  end
end
