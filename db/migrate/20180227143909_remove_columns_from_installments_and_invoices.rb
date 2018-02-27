class RemoveColumnsFromInstallmentsAndInvoices < ActiveRecord::Migration[5.1]
  def change
    remove_column :installments, :outstanding_days
    remove_monetize :installments, :interest
    remove_monetize :installments, :ad_valorem

    remove_column :invoices, :average_outstanding_days
    remove_monetize :invoices, :average_interest
    remove_monetize :invoices, :average_ad_valorem
  end
end
