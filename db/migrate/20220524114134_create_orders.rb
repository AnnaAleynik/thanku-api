class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.string :comment, null: true
      t.string :status, null: false, default: "created"

      t.references :product, null: false
      t.references :user, null: false
      t.references :manager,  foreign_key: { to_table: :users }, null: true

      t.timestamps
    end
  end
end
