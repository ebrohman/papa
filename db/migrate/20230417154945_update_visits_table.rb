# frozen_string_literal: true

class UpdateVisitsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :visits, :pal_id
  end
end
