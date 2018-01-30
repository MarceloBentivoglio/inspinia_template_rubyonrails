class AddEmailToSeller < ActiveRecord::Migration[5.1]
  def change
    add_column :sellers, :email, :string
    add_column :payers, :email, :string
  end
end
