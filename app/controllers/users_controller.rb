# frozen_string_literal: true

class UsersController < ApplicationController
  api :POST, '/users'

  def create
    user = User.new(user_params.except(:role_name))
    # binding.break
    role = Role.find_by!(name: user_params[:role_name])
    user_role = UserRole.new(user:, role:)
    user.user_roles << user_role

    if user.save
      user.auth_token
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
