class CreateQualitativeInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :qualitative_informations do |t|
      t.references :seller, foreign_key: true
      t.boolean :address_verification
      t.string :address_verification_observation
      t.integer :law_suits_quantity
      t.monetize :law_suits_amount
      t.string :website
      t.string :google
      t.string :linkedin
      t.string :facebook
      t.string :corporate_email
      t.string :reclame_aqui
      t.integer :reclame_aqui_complaints_quantity
      t.integer :reclame_aqui_answered_complaints
      t.string :google_maps
      t.string :information_year

      t.timestamps
    end
  end
end
