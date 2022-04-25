class RemoveOwnerFromCompany < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :companies, to_table: :users, column: :owner_id
    safety_assured { remove_reference(:companies, :owner) }
  end
end
