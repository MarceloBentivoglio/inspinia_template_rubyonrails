class CreateSellersLimits < ActiveRecord::Migration[5.1]
  def change
    create_table :sellers_limits do |t|
      t.references :seller, foreign_key: true
      t.monetize :total_limit
      t.monetize :used_limit
      t.references :operation, foreign_key: true

      t.timestamps
    end
  end
end
