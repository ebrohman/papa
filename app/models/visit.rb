# frozen_string_literal: true

class Visit < ApplicationRecord
  # belongs_to :user, foreign_key: :member_id
  belongs_to :member, class_name: 'User'

  validates :minutes, presence: true
  validates :rate, presence: true

  scope :unfulfilled, -> { where(completed_at: nil, date: DateTime.current..).order(date: :desc) }
  scope :fulfilled, -> { where.not(completed_at: nil) }

  def cost
    minutes * rate
  end
end
