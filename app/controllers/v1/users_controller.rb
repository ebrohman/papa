# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    rescue_from Apipie::ParamError do |e|
      render json: e.message, status: :unprocessable_entity
    end

    api :GET, '/v1/users', 'Get a list of users'

    def index
      render json: User.all
    end

    api :POST, '/v1/users', 'Create a new user'
    param :email, String, required: true
    param :first_name, String
    param :last_name, String

    def create
      Commands::CreateUser.call(user_params).then do |result|
        render json: result.message, status: result.status
      end
    end

    private

    def user_params
      params.permit(:email, :password, :first_name, :last_name)
    end
  end
end
