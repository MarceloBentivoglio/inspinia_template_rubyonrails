class RemoveLawSuitsFromQualitativeInformation < ActiveRecord::Migration[5.1]
  def change
    remove_column :qualitative_informations, :law_suits_quantity
    remove_monetize :qualitative_informations, :law_suits_amount

  end
end
