class CreateSellersConcentrations < ActiveRecord::Migration[5.1]
  def change
    create_table :sellers_concentrations do |t|
      t.references :seller, foreign_key: true
      t.references :operation, foreign_key: true
      t.monetize :concentration

      t.timestamps
    end
  end
end
