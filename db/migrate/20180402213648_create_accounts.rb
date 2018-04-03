class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :color, null: false
      t.string :weapon, null: false, default: 'unarmed'
    end
  end
end
