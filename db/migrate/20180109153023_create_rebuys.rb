class CreateRebuys < ActiveRecord::Migration[5.1]
  def change
    create_table :rebuys do |t|
      t.references :operation, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
