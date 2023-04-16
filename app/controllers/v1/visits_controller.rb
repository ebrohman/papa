# frozen_string_literal: true

module V1
  class VisitsController < ApplicationController
    api :POST, '/v1/visits', 'Create a new visit'
    param :member_id, Integer, required: true
    param :date, String, required: true
    param :rate, Float, required: true
    param :minutes, Integer, required: true

    def create
      Commands::CreateVisit.call(create_visit_params).then do |result|
        render json: result.message, status: result.status
      end
    end

    private

    def create_visit_params
      params.permit(:member_id, :date, :rate, :minutes)
    end
  end
end
