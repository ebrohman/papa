# frozen_string_literal: true

module V1
  class VisitsController < ApplicationController
    api :GET, '/v1/visits/unfulfilled', 'List unfulfilled visits'

    def unfulfilled
      render json: Visit.unfulfilled
    end

    api :GET, '/v1/visits/fulfilled', 'List fulfilled visits'

    def fulfilled
      render json: Visit.fulfilled
    end

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

    api :POST, '/v1/visits/fulfill', 'Fulfill a visit'
    param :pal_id, Integer, required: true
    param :visit_id, Integer, required: true

    def fulfill
      Commands::FulfillVisit.call(request_visit_params).then do |result|
        render json: result.message, status: result.status
      end
    end

    private

    def request_visit_params
      params.permit(:pal_id, :visit_id)
    end

    def create_visit_params
      params.permit(:member_id, :date, :rate, :minutes)
    end
  end
end
