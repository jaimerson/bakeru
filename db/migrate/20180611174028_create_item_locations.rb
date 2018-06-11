class CreateItemLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :item_locations do |t|
      t.references :item
      t.references :location
      t.string :map_location, null: false, default: '0,0'
    end
  end
end
