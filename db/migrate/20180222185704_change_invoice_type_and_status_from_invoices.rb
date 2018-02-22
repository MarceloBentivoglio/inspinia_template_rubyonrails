class ChangeInvoiceTypeAndStatusFromInvoices < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :status
    remove_column :invoices, :invoice_type
    add_column :invoices, :invoice_type, :integer, default: 0
    remove_column :invoices, :delivery_status
    add_column :invoices, :delivery_status, :integer
    add_column :invoices, :backoffice_status, :integer, default: 0
    add_column :invoices, :sale_status, :integer, default: 0
  end
end
