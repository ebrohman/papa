# frozen_string_literal: true

class Role < ApplicationRecord
  enum :name, { member: 0, pal: 1 }

  validates :name, inclusion: { in: names.keys }
end
