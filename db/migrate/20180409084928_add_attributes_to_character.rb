class AddAttributesToCharacter < ActiveRecord::Migration[5.0]
  def change
    change_table :characters do |t|
      t.integer :vitality, null: false, default: 1
      t.integer :strength, null: false, default: 1
      t.integer :magic, null: false, default: 1
      t.integer :endurance, null: false, default: 1
    end
  end
end
