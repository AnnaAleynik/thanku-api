class AddForeignKeyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :users, :companies, validate: false
  end
end
