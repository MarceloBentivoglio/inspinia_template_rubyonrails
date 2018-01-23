class PayersLimit < ApplicationRecord
  belongs_to :payer
  belongs_to :operation
end
