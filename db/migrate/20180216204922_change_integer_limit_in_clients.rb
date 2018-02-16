class ChangeIntegerLimitInClients < ActiveRecord::Migration[5.1]
  def change
    change_column :clients, :available_funds_cents, :integer, limit: 8
  end
end
