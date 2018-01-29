class CreateSeasonSales < ActiveRecord::Migration[5.1]
  def change
    create_table :season_sales do |t|
      t.references :seller, foreign_key: true
      t.boolean :jan
      t.boolean :feb
      t.boolean :mar
      t.boolean :apr
      t.boolean :may
      t.boolean :jun
      t.boolean :jul
      t.boolean :aug
      t.boolean :sep
      t.boolean :oct
      t.boolean :nov
      t.boolean :dec
      t.string :information_year

      t.timestamps
    end
  end
end
