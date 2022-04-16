class AddPropertiesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :login, :string
    add_column :users, :bonus_balance, :integer, null: false, default: 0
    add_column :users, :bonus_allowance, :integer, null: false, default: 500
    add_column :users, :role, :string, null: false, default: "account"
    add_column :users, :birthdate, :date
  end
end
