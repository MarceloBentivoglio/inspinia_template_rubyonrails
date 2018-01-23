class Payer < ApplicationRecord
  has_many :equity_holders
  has_many :payers_limits
  has_many :payers_concentrations
  has_many :invoices

  validates :identification_number, uniqueness: true
end
