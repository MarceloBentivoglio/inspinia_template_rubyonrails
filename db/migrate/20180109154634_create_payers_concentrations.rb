class CreatePayersConcentrations < ActiveRecord::Migration[5.1]
  def change
    create_table :payers_concentrations do |t|
      t.references :payer, foreign_key: true
      t.references :operation, foreign_key: true
      t.monetize :concentration

      t.timestamps
    end
  end
end
