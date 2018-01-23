class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.string :type
      t.string :invoice_number
      t.string :contract_number
      t.string :check_number
      t.string :status
      t.string :delivery_status
      t.boolean :confirmed
      t.boolean :notified
      t.boolean :boleto_especial
      t.integer :average_outstanding_days
      t.monetize :total_value
      t.monetize :average_interest
      t.monetize :average_ad_valorem

      t.timestamps
    end
  end
end
