class AddStatesToInstallments < ActiveRecord::Migration[5.1]
  def change
    remove_column :installments, :status
    add_column :installments, :paid, :boolean, default: false
  end
end
