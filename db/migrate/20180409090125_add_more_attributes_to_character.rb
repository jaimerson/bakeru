class AddMoreAttributesToCharacter < ActiveRecord::Migration[5.0]
  def change
    change_table :characters do |t|
      t.string :name, null: false
      t.integer :level, null: false, default: 1
    end
  end
end
