class Roles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.integer :name, default: 0, null: false
    end
  end
end
