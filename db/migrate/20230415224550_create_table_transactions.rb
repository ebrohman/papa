# frozen_string_literal: true

class CreateTableTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.timestamps
      t.references :member, foreign_key: { to_table: :users, index: true }
      t.references :pal, foreign_key: { to_table: :users, index: true }
      t.decimal :amount, scale: 2, precision: 8, null: false
    end
  end
end
