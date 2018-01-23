class SellersConcentration < ApplicationRecord
  belongs_to :seller
  belongs_to :operation
end
