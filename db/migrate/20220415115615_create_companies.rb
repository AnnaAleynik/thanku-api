class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :description, null: true
      t.references :owner, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
