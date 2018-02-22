class AddBuyerToInvoice < ActiveRecord::Migration[5.1]
  def change
    add_reference :invoices, :buyer, foreign_key: { to_table: :clients}
  end
end
