class AddPhoneToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :sellers, :phone_number, :string
    add_column :payers, :phone_number, :string
  end
end
