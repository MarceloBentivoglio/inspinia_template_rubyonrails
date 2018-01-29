class CreateFinantials < ActiveRecord::Migration[5.1]
  def change
    create_table :finantials do |t|
      t.references :seller, foreign_key: true
      t.string :production_economics_cycle_description
      t.integer :employee_quantity
      t.monetize :total_wages_cost
      t.monetize :rent_cost
      t.monetize :relevant_fixed_cost
      t.monetize :cost_of_goods_sold
      t.monetize :ebitda
      t.string :information_year

      t.timestamps
    end
  end
end
