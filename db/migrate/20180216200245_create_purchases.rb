class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.references :buyer, foreign_key: { to_table: :clients}
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
