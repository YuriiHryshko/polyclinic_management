class AddPhoneFirstNameLastNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone, :string, null: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_index :users, :phone, unique: true
  end
end
