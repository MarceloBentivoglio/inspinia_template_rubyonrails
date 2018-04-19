class AddNicknameToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :company_nickname, :string
  end
end
