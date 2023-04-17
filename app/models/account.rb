# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :user_id

  def balance
    # This is a decimal at the DB to ensure precision
    # But I want it to act like a currency amount
    super.to_f.round(2)
  end
end
