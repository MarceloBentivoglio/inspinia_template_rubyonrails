class RemoveStatusFromOperations < ActiveRecord::Migration[5.1]
  def change
    remove_column :operations, :status
  end
end
