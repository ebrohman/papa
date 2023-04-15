# frozen_string_literal: true

class ChangeVisitField < ActiveRecord::Migration[7.0]
  def change
    change_column(:visits, :date, :datetime)
  end
end
