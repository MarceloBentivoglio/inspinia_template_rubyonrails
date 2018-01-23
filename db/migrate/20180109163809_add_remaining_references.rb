class AddRemainingReferences < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :client, foreign_key: true
    add_reference :invoices, :operation, foreign_key: true
    add_reference :invoices, :payer, foreign_key: true
  end
end
