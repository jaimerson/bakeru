class ChangeAccountsToCharacters < ActiveRecord::Migration[5.0]
  def change
    rename_table :accounts, :characters
  end
end
