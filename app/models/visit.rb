# frozen_string_literal: true

class Visit < ApplicationRecord
  belongs_to :user, foreign_key: :member_id

  validates :minutes, presence: true
  validates :rate, presence: true
end
