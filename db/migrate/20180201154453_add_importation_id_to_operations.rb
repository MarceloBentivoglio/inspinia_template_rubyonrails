class AddImportationIdToOperations < ActiveRecord::Migration[5.1]
  def change
    add_column :operations, :importation_reference, :string
  end
end
