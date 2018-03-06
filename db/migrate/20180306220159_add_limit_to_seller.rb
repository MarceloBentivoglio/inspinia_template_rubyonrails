class AddLimitToSeller < ActiveRecord::Migration[5.1]
  def change
    add_monetize :sellers, :limit
  end
end
