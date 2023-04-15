# frozen_string_literal: true

class AddVisitsAndAccountsTimestamps < ActiveRecord::Migration[7.0]
  def change
    add_timestamps :visits
    add_timestamps :accounts
  end
end
