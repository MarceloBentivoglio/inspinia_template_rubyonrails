class ChangeAverageOutstandingDaysToFloat < ActiveRecord::Migration[5.1]
  def change
    remove_column :operations, :average_outstanding_days, :integer
    add_column :operations, :average_outstanding_days, :float
    remove_column :invoices, :average_outstanding_days, :integer
    add_column :invoices, :average_outstanding_days, :float
  end
end
