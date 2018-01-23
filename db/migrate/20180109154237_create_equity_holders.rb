class CreateEquityHolders < ActiveRecord::Migration[5.1]
  def change
    create_table :equity_holders do |t|
      t.references :payer, foreign_key: true
      t.references :seller, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :cpf
      t.datetime :birthday
      t.string :nationality
      t.string :phone_number
      t.string :email
      t.string :total_equity
      t.string :ordinary_equity
      t.string :signature
      t.datetime :partnership_date
      t.string :zip_code
      t.string :address
      t.string :address_number
      t.string :neigborhood
      t.string :address_2
      t.string :state
      t.string :city

      t.timestamps
    end
  end
end
