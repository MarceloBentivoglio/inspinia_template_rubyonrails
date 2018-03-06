class AddDatesToInstallments < ActiveRecord::Migration[5.1]
  def change
    add_column :installments, :deposit_date, :datetime
    add_column :installments, :receipt_date, :datetime
  end
end
