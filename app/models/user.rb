# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  has_one :account

  # filter out password digest
  def as_json(options = {})
    super(options).except('password_digest')
  end
end
