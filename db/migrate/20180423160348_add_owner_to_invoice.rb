class AddOwnerToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_reference :invoices, :owner, foreign_key: { to_table: :clients}
  end
end
