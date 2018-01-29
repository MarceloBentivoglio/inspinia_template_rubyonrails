  class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :type
      t.string :name
      t.string :cnpj
      t.monetize :available_funds

      t.timestamps
    end
  end
end
