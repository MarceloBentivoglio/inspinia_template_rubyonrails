class AddColumnsToOperations < ActiveRecord::Migration[5.1]
  def change
    add_monetize :operations, :deposit_value
  end
end
