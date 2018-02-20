class AddStatusToInstallments < ActiveRecord::Migration[5.1]
  def change
    add_column :installments, :status, :string
  end
end
