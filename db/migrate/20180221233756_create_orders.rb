class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :buyer, foreign_key: { to_table: :clients }

      t.timestamps
    end
  end
end
