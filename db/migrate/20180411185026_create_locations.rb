class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :template, null: false
      t.jsonb :tiles, null: false
    end
  end
end
