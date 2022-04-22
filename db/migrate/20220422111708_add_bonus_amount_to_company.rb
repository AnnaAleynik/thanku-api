class AddBonusAmountToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :bonus_amount, :integer, null: false, default: 100
  end
end
