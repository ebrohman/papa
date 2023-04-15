# frozen_string_literal: true

class AlterTableUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :password_digest
    remove_column :users, :auth_token
    add_timestamps :users
  end
end
