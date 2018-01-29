class CreateDebts < ActiveRecord::Migration[5.1]
  def change
    create_table :debts do |t|
      t.references :seller, foreign_key: true
      t.references :finantial_institution, foreign_key: true
      t.references :debt_type, foreign_key: true
      t.monetize :total_amount
      t.monetize :balance_amount
      t.integer :installments_quantity
      t.string :information_year

      t.timestamps
    end
  end
end
