class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.references :character, index: true
    end

    create_table :items do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.string :description
      t.jsonb :data, null: false, default: {}
      t.decimal :weight, null: false, default: 0

      t.references :inventory, index: true
    end

    create_table :equipment do |t|
      t.integer :left_hand_item_id
      t.integer :right_hand_item_id
      t.references :character
    end
  end
end
