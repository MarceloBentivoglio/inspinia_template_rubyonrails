class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
