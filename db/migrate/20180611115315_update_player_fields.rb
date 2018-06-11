class UpdatePlayerFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :characters, :weapon, null: false, default: :unarmed
    change_table :characters do |t|
      t.integer :last_location_id
    end
  end
end
