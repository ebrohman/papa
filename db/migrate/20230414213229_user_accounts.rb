# frozen_string_literal: true

class UserAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.decimal :balance, scale: 2, precision: 8
      t.references :user, foreign_key: true
    end
  end
end
