# frozen_string_literal: true

class UsersController < ApplicationController
  api :POST, '/users', 'Create a new user'
  param :email, String, required: true
  param :first_name, String
  param :last_name, String
  param :role_name, %w[member pal], required: true

  rescue_from Apipie::ParamError do |e|
    render json: e.message, status: :unprocessable_entity
  end

  def create
    user = User.new(user_params.except(:role_name))

    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :first_name, :last_name, :role_name)
  end
end
