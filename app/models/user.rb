# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  has_many :user_roles
  has_many :roles, through: :user_roles

  def member?
    roles.where(name: :member).exists?
  end

  def pal?
    roles.where(name: :pal).exists?
  end

  # filter out password digest
  def as_json(options = {})
    super(options).except('password_digest')
  end
end
