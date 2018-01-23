class EquityHolder < ApplicationRecord
  belongs_to :payer
  belongs_to :seller
end
