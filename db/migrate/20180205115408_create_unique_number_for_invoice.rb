class CreateUniqueNumberForInvoice < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :invoice_number, :string
    remove_column :invoices, :contract_number, :string
    remove_column :invoices, :check_number, :string
    add_column :invoices, :number, :string
  end
end
