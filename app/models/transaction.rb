# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :member, class_name: 'User'
  belongs_to :pal, class_name: 'User'

  validates :amount, presence: true
end
