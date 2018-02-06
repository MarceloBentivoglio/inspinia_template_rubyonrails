class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :operations, :approval_date, :deposit_date
  end
end
