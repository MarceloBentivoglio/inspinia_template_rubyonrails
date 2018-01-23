class PayersConcentration < ApplicationRecord
  belongs_to :payer
  belongs_to :operation
end
