class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: true
      t.integer :count, null: false, default: 0
      t.integer :price, null: false, default: 0
      t.text :picture_data, null: true

      t.references :company, null: false

      t.timestamps
    end
  end
end
