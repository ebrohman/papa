# frozen_string_literal: true

class DropTableRoles < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_roles, force: :cascade
    drop_table :roles
  end
end
