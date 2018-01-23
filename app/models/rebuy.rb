class Rebuy < ApplicationRecord
  belongs_to :operation
  belongs_to :invoice
end
