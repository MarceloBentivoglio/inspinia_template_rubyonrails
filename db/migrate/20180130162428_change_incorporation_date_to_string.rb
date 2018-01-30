class ChangeIncorporationDateToString < ActiveRecord::Migration[5.1]
  def change
    change_column :sellers, :incorporation_date, :string
  end
end
