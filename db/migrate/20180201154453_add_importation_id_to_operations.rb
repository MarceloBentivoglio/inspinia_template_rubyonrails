class AddImportationIdToOperations < ActiveRecord::Migration[5.1]
  def change
    add_column :operations, :importation_reference, :string
    add_column :invoices, :importation_reference, :string
    add_column :installments, :importation_reference, :string
  end
end
