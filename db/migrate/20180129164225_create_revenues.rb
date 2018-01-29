class CreateRevenues < ActiveRecord::Migration[5.1]
  def change
    create_table :revenues do |t|
      t.references :seller, foreign_key: true
      t.monetize :jan
      t.monetize :feb
      t.monetize :mar
      t.monetize :apr
      t.monetize :may
      t.monetize :jun
      t.monetize :jul
      t.monetize :aug
      t.monetize :sep
      t.monetize :oct
      t.monetize :nov
      t.monetize :dec
      t.string :information_year

      t.timestamps
    end
  end
end
