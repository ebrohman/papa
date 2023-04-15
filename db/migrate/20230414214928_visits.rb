# frozen_string_literal: true

class Visits < ActiveRecord::Migration[7.0]
  def change
    create_table :visits do |t|
      t.date :date, null: false
      t.integer :minutes, null: false
      t.date :completed_at, index: true
      t.references :member, foreign_key: { to_table: :users, index: true }
      t.references :pal, foreign_key: { to_table: :users, index: true }
    end
  end
end
