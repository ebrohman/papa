# frozen_string_literal: true

class CreatueUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }
      t.string :first_name
      t.string :last_name
      t.string :password_digest, unique: true
      t.string :auth_token, index: { unique: true }
    end
  end
end
