class CreateInstallments < ActiveRecord::Migration[5.1]
  def change
    create_table :installments do |t|
      t.references :invoice, foreign_key: true
      t.string :number
      t.monetize :value
      t.datetime :due_date
      t.integer :outstanding_days
      t.monetize :interest
      t.monetize :ad_valorem

      t.timestamps
    end
  end
end
