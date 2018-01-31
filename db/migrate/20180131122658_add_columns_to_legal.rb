class AddColumnsToLegal < ActiveRecord::Migration[5.1]
  def change
    add_column :legals, :civil_suits_quantity, :integer
    add_monetize :legals, :civil_suits_amount
    add_column :legals, :labor_suits_quantity, :integer
    add_monetize :legals, :labor_suits_amount
    add_column :legals, :penal_suits_quantity, :integer
    add_monetize :legals, :penal_suits_amount
    add_column :legals, :fiscal_suits_quantity, :integer
    add_monetize :legals, :fiscal_suits_amount
    add_column :legals, :enforcement_monition_suits_quantity, :integer
    add_monetize :legals, :enforcement_monition_suits_amount
    add_column :legals, :information_year, :string
  end
end
