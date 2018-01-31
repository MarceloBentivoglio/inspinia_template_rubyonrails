class CreateLegals < ActiveRecord::Migration[5.1]
  def change
    create_table :legals do |t|
      t.references :seller, foreign_key: true

      t.timestamps
    end
  end
end
