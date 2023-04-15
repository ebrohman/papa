# frozen_string_literal: true

class AlterTableVisits < ActiveRecord::Migration[7.0]
  def change
    add_column :visits, :rate, :decimal, null: false, precision: 8, scale: 2, default: 1
  end
end
