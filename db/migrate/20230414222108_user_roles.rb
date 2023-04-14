class UserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.references :role, foreign_key: { index: true }
      t.references :user, foreign_key: { index: true }
    end
  end
end
