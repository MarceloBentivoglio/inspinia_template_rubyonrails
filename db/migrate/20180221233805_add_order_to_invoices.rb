class AddOrderToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_reference :invoices, :order, foreign_key: true
  end
end
