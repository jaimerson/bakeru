class AddFieldsToLocation < ActiveRecord::Migration[5.0]
  def change
    change_table :locations do |t|
      t.references :character, foreign_key: true
    end
  end
end
