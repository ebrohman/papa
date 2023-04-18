# frozen_string_literal: true

class ApplicationController < ActionController::API
  def route_not_found
    render json: { error: "endpoint not available"}, status: :not_found
  end
end
