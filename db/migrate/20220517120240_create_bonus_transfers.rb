class CreateBonusTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :bonus_transfers do |t|
      t.integer :amount, null: false
      t.string :comment, null: false
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.references :receiver, foreign_key: { to_table: :users }, null: false
      t.references :parent, foreign_key: { to_table: :bonus_transfers }, null: true

      t.timestamps
    end
  end
end
