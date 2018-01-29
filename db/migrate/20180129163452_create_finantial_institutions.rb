class CreateFinantialInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :finantial_institutions do |t|
      t.string :name

      t.timestamps
    end
  end
end
