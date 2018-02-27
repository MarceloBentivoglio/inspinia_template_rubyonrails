class CreateRejections < ActiveRecord::Migration[5.1]
  def change
    create_table :rejections do |t|
      t.belongs_to :invoice, foreign_key: true
      t.belongs_to :rejector, foreign_key: { to_table: :clients }
      t.integer :motive
      t.text :motive_detail

      t.timestamps
    end
  end
end
